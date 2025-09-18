import 'dart:developer';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:project_management_app/application/helpers/get_storage.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import '../../../../application/services/signaling_service.dart';

class VideoCallViewModel extends BaseViewModel {
  VideoCallViewModel(super.tokenManager, this._signalingService, this._localStorage);

  final LocalStorage _localStorage;
  final SignalingService _signalingService;

  bool _loading = true;
  bool get loading => _loading;

  bool cameraOn = true;
  bool micOn = true;

  int? _meetId = 1;
  int get meetId => _meetId!;

  void setMeetId(int id) {
    _meetId = id;
  }

  final RTCVideoRenderer localRenderer = RTCVideoRenderer();
  MediaStream? _localStream;

  // backend sessionId (assigned by WS)
  String? sessionId;

  final Map<int, RTCPeerConnection> _pcs = {};
  final Map<int, RTCVideoRenderer> _remoteRenderers = {};

  List<MapEntry<int, RTCVideoRenderer>> get remoteTiles =>
      _remoteRenderers.entries.toList(growable: false);

  Future<void> init() async {
    await localRenderer.initialize();

    _localStream = await navigator.mediaDevices.getUserMedia({
      "audio": true,
      "video": {
        "facingMode": "user",
        "width": {"ideal": 1920},   // Full HD
        "height": {"ideal": 1080},
        "frameRate": {"ideal": 30, "max": 60}
      }
    });
    localRenderer.srcObject = _localStream;

    _signalingService.connect();
    _signalingService.onMessageReceived = _handleSignal;

    // announce myself to meeting
    _signalingService.send({
      "type": "join",
      "meetId": meetId,
    });

    _loading = false;
    notifyListeners();
  }

  Future<RTCPeerConnection> _pcFor(int peerId) async {
    if (_pcs.containsKey(peerId)) return _pcs[peerId]!;

    final config = {
      "iceServers": [
        {"urls": "stun:stun1.l.google.com:19302"},
        {"urls": "stun:stun2.l.google.com:19302"},
      ]
    };

    final pc = await createPeerConnection(config);

    // add local tracks
    _localStream?.getTracks().forEach((t) => pc.addTrack(t, _localStream!));

    // remote stream
    pc.onTrack = (evt) async {
      if (evt.streams.isNotEmpty) {
        final stream = evt.streams.first;
        if (!_remoteRenderers.containsKey(peerId)) {
          final r = RTCVideoRenderer();
          await r.initialize();
          r.srcObject = stream;
          _remoteRenderers[peerId] = r;
          notifyListeners();
        } else {
          _remoteRenderers[peerId]!.srcObject = stream;
          notifyListeners();
        }
      }
    };

    // ICE candidates
    pc.onIceCandidate = (c) {
      if (c.candidate != null) {
        _signalingService.send({
          "type": "candidate",
          "meetId": meetId,
          "peerId": peerId,
          "candidate": {
            "candidate": c.candidate,
            "sdpMid": c.sdpMid,
            "sdpMLineIndex": c.sdpMLineIndex
          }
        });
      }
    };

    _pcs[peerId] = pc;
    return pc;
  }

  Future<void> createOfferTo(int peerId) async {
    final pc = await _pcFor(peerId);
    final offer = await pc.createOffer();
    await pc.setLocalDescription(offer);
    log("Offer created: $offer");
    _signalingService.send({
      "type": "offer",
      "meetId": meetId,
      "peerId": peerId,
      "sdp": offer.sdp,
    });
  }

  Future<void> _handleSignal(Map<String, dynamic> m) async {
    final type = m["type"] as String?;
    final peerId = m["meetId"] as  int? ;

    log("Signal received: $m");

    switch (type) {
      case "peers":
        final List peers = m["list"] ?? [];
        for (final pid in peers) {
          await createOfferTo(pid);
        }
        break;

      case "join":
        if (peerId != null) {
          await createOfferTo(peerId);
        }
        break;

      case "offer":
        {
          final pc = await _pcFor(peerId!);
          await pc.setRemoteDescription(RTCSessionDescription(m["sdp"], "offer"));
          final answer = await pc.createAnswer();
          await pc.setLocalDescription(answer);
          _signalingService.send({
            "type": "answer",
            "meetId": meetId,
            "peerId": peerId,
            "sdp": answer.sdp,
          });
        }
        break;

      case "answer":
        {
          final pc = await _pcFor(peerId!);
          await pc.setRemoteDescription(RTCSessionDescription(m["sdp"], "answer"));
        }
        break;

      case "candidate":
        {
          final pc = await _pcFor(peerId!);
          final c = m["candidate"];
          await pc.addCandidate(
            RTCIceCandidate(c["candidate"], c["sdpMid"], c["sdpMLineIndex"]),
          );
        }
        break;

      case "leave":
        if (peerId != null) {
          removePeer(peerId);
        }
        break;
    }
  }

  void toggleMic() {
    micOn = !micOn;
    _localStream?.getAudioTracks().forEach((t) => t.enabled = micOn);
    notifyListeners();
  }

  void toggleCamera() {
    cameraOn = !cameraOn;
    _localStream?.getVideoTracks().forEach((t) => t.enabled = cameraOn);
    notifyListeners();
  }

  Future<void> removePeer(int peerId) async {
    final r = _remoteRenderers.remove(peerId);
    await r?.dispose();
    final pc = _pcs.remove(peerId);
    await pc?.close();
    notifyListeners();
  }

  Future<void> end() async {
    for (final r in _remoteRenderers.values) {
      await r.dispose();
    }
    _remoteRenderers.clear();

    for (final pc in _pcs.values) {
      await pc.close();
    }
    _pcs.clear();

    await localRenderer.dispose();
    _signalingService.close();

    _localStream?.getTracks().forEach((t) => t.stop());
  }
}

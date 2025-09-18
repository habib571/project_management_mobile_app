import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRTCService {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  Future<void> init() async {
    // Get local stream
    final mediaConstraints = {
      'audio': true,
      'video': {'facingMode': 'user'}
    };

    _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);

    // Create peer connection
    _peerConnection = await createPeerConnection({});

    // Add local stream tracks
    _localStream?.getTracks().forEach((track) {
      _peerConnection?.addTrack(track, _localStream!);
    });
  }

  MediaStream? getLocalStream() => _localStream;
}

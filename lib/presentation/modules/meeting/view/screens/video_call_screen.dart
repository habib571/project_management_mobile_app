import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:project_management_app/presentation/modules/meeting/view/screens/voice_call_screen.dart';
import 'package:project_management_app/presentation/modules/meeting/view/widgets/video_call_buttons.dart';
import 'package:provider/provider.dart';

import '../../viewModels/video_call_view_model.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  Offset _floatingPosition = const Offset(20, 60); // initial position

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VideoCallViewModel>().init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<VideoCallViewModel>();
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: viewModel.loading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.remoteTiles.isEmpty
                    ? viewModel.cameraOn
                        ? RTCVideoView(
                            viewModel.localRenderer,
                            objectFit: RTCVideoViewObjectFit
                                .RTCVideoViewObjectFitCover,
                            mirror: true,
                          )
                        : const VoiceCallScreen(name: "Habib", imageUrl: "")
                    : viewModel.remoteTiles.length == 1
                        // full screen for one-to-one
                        ? RTCVideoView(
                            viewModel.remoteTiles.first.value,
                            objectFit: RTCVideoViewObjectFit
                                .RTCVideoViewObjectFitCover,
                          )
                        // grid for group call
                        : GridView.builder(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 96),
                            itemCount: viewModel.remoteTiles.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                            ),
                            itemBuilder: (ctx, i) {
                              final renderer = viewModel.remoteTiles[i].value;
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: RTCVideoView(
                                  renderer,
                                  objectFit: RTCVideoViewObjectFit
                                      .RTCVideoViewObjectFitCover,
                                ),
                              );
                            },
                          ),
          ),
          viewModel.remoteTiles.isNotEmpty
              ? viewModel.cameraOn
                  ? Positioned(
                      left: _floatingPosition.dx,
                      top: _floatingPosition.dy,
                      child: Draggable(
                        feedback: _buildLocalPreview(viewModel),
                        childWhenDragging: const SizedBox.shrink(),
                        onDragEnd: (details) {
                          setState(() {
                            _floatingPosition = details.offset;
                          });
                        },
                        child: _buildLocalPreview(viewModel),
                      ),
                    )
                  : const VoiceCallScreen(name: "Habib", imageUrl: "")
              : const SizedBox.shrink(),
          Align(
            alignment: Alignment.bottomCenter,
            child: VideoCallButtons(
              isVolumeOn: true,
              isCameraOn: viewModel.cameraOn,
              isMicOn: viewModel.micOn,
              onCameraToggle: () {
                viewModel.toggleCamera();
              },
              onMicToggle: () {
                viewModel.toggleMic();
              },
              onEndCall: () {
                viewModel.end();
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLocalPreview(VideoCallViewModel vm) {
    return Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: RTCVideoView(
          vm.localRenderer,
          mirror: true,
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class VideoCallButtons extends StatelessWidget {
  const VideoCallButtons({
    super.key,
    required this.isCameraOn,
    required this.isMicOn,
    required this.onCameraToggle,
    required this.onMicToggle,
    required this.onEndCall, required this.isVolumeOn,
  });

  final bool isCameraOn, isMicOn , isVolumeOn;
  final VoidCallback onCameraToggle, onMicToggle, onEndCall;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ActionButton(
            tooltip: "End Call",
            backgroundColor: Colors.red,
            icon: Icons.call_end,
            onPressed: onEndCall,
          ),
          const SizedBox(width: 20),
          _ActionButton(
            tooltip: isCameraOn ? "Turn Off Camera" : "Turn On Camera",
            backgroundColor: Colors.white24,
            icon: isCameraOn ? Icons.videocam : Icons.videocam_off,
            onPressed: onCameraToggle,
          ),
          const SizedBox(width: 20),
          _ActionButton(
            tooltip: isVolumeOn ? "Speaker on" : "speaker off",
            backgroundColor: Colors.white24,
            icon: isMicOn ? Icons.volume_up : Icons.volume_off,
            onPressed: onMicToggle,
          ),
          const SizedBox(width: 20),
          _ActionButton(
            tooltip: isMicOn ? "Mute Mic" : "Unmute Mic",
            backgroundColor: Colors.white24,
            icon: isMicOn ? Icons.mic : Icons.mic_off,
            onPressed: onMicToggle,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = Colors.white24,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onPressed,
        child: CircleAvatar(
          radius: 22,
          backgroundColor: backgroundColor,
          child: Icon(icon, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}

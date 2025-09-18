import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';

import '../../../../utils/styles.dart';

class VoiceCallScreen extends StatelessWidget {
  const VoiceCallScreen(
      {super.key, required this.name, required this.imageUrl});
  final String name;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black12.withOpacity(0.7),
        child: Center(
            child: ImagePlaceHolder(
                radius: 25, imageUrl: imageUrl, fullName: name)));
  }
}

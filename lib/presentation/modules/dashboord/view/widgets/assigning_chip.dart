import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../sharedwidgets/image_widget.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';

class AssigningChip extends StatelessWidget {
  const AssigningChip({super.key, required this.avatar, required this.objectName, required this.onDeleted,  this.backgroundColor, });
  final Widget avatar ;
  final String  objectName ;
  final Function onDeleted ;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(
        objectName ,
        style: robotoBold.copyWith(fontSize: 12),
      ),
      backgroundColor: backgroundColor ?? AppColors.accent,
      avatar: avatar ,
      //ImagePlaceHolder(radius: 30, imageUrl: imageUrl) ,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18), // Adjust border radius here
      ),
      onDeleted: () => onDeleted(),
    ) ;
  }
}


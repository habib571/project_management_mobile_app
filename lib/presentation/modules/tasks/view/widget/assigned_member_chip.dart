import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

import '../../../../../domain/models/user.dart';

class AssignedMemberChip extends StatelessWidget {
  const AssignedMemberChip({super.key, required this.imageUrl, required this.userName, required this.onDeleted});
 final String? imageUrl ;
 final String  userName ;
 final Function onDeleted ;
  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(
        userName ,
        style: robotoBold.copyWith(fontSize: 12),
      ),
      backgroundColor: AppColors.accent,
      avatar: ImagePlaceHolder(
          radius: 30,
          imageUrl: imageUrl,
          fullName: userName,
      ) ,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      onDeleted: () => onDeleted(),
    ) ;
  }
}

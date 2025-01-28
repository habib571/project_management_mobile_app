import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';

import '../utils/colors.dart';

class CustomAddButton extends StatelessWidget{
  final Function()? onTap;
  const CustomAddButton({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        width: 33,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 2),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(Icons.add,
              size: 25, color: AppColors.primary), // Adjust size if needed
        ),
      ),
    );
  }

}
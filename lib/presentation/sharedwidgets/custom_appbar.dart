import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, this.onPressed});
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (onPressed != null) {
              onPressed!();
            }
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),

        Expanded(
          child: Center(
            child: Text(
              title,
              style: robotoBold.copyWith(fontSize: 18),
            ),
          ),
        ),

        const SizedBox(width: 48),
      ],
    );
  }
}
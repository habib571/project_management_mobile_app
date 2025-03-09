import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
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
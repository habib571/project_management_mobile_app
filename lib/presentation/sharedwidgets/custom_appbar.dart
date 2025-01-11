import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});
  final String title ;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back() ;
                  },
                  icon: const Icon(Icons.arrow_back_rounded)),
              Text(title, style: robotoBold.copyWith(fontSize: 18),)
            ],
          ),
        ),
        const Expanded( flex : 4 ,child: SizedBox())
      ],
    ) ;
  }
}

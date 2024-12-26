import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.buttonColor = AppColors.primary,
      required this.onPressed,
      required this.text,
      this.widget = const SizedBox(),
      this.height ,
        this.borderRadius =40
      });
  final Color buttonColor;
  final String text;
  final Function() onPressed;
  final Widget widget;
  final TextStyle btnTxtStyle =
      robotoMedium.copyWith(color: Colors.white, fontSize: 16);
  final double? height;
  final double borderRadius ;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: height ?? 55,
            child: MaterialButton(
              color: buttonColor,
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius)),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget,
                  Text(
                    text,
                    style: btnTxtStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

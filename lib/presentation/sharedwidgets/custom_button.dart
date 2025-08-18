import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.buttonColor = AppColors.primary,
      required this.onPressed,
      required this.text,
      this.widget = const SizedBox(),
      this.height,
        this.borderRadius =40,
        this.textColor  = Colors.white,
        this.padding =12
      });
  final Color buttonColor;
  final Color textColor ;
  final String text;
  final Function() onPressed;
  final Widget widget;
  final double? height;
  final double borderRadius ;
  final double padding ;


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
              padding:  EdgeInsets.symmetric(vertical: padding),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius)),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget,
                  const SizedBox(width: 10,) ,
                  Text(
                    text,
                    style: robotoMedium.copyWith(color: textColor, fontSize: 16) ,
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

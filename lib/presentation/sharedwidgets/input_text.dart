import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';


class InputText extends StatelessWidget {
  InputText(
      {super.key,
        this.readOnly = false,
        this.controller,
        this.textInputType = TextInputType.text,
        this.hintText = "",
        this.borderRadius = 40,
        this.validator,
        this.onChanged,
        this.suffixIcon,
        this.obscureText = false,
        this.maxLines = 1
      });
  final bool readOnly;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final String hintText;
  final double borderRadius;
  final String? Function(String? s)? validator;
  void Function(String)? onChanged ;
  Widget? suffixIcon;
  int maxLines;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      readOnly: readOnly,
      cursorColor: Colors.black,
      controller: controller,
      keyboardType: textInputType,
      style: robotoRegular.copyWith(fontSize: 13),
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: robotoRegular.copyWith(color: AppColors.secondaryTxt),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius),
          )),
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,


    );
  }
}
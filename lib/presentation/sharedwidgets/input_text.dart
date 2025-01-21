import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';


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
        this.prefixIcon,
        this.obscureText = false,
        this.maxLines = 1,
        this.onTap,
        this.borderSide = BorderSide.none ,
      });
  final bool readOnly;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final String hintText;
  double borderRadius;
  final String? Function(String? s)? validator;
  void Function(String)? onChanged ;
  void Function()? onTap;
  Widget? suffixIcon;
  Widget? prefixIcon ;
  int maxLines;
  BorderSide borderSide  ;


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
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: robotoRegular.copyWith(color: AppColors.secondaryTxt),
          border: OutlineInputBorder(
            borderSide: borderSide,
            borderRadius: BorderRadius.circular(borderRadius),
          )),
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscureText,


    );
  }
}


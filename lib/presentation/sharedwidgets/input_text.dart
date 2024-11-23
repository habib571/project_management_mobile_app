import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/theme/colors.dart';
import 'package:project_management_app/presentation/theme/styles.dart';

class InputText extends StatelessWidget {
  const InputText(
      {super.key,
      this.readOnly = false,
      this.controller,
      this.textInputType = TextInputType.text,
      this.hintText = "",
      this.borderRadius = 40,
      this.validator});
  final bool readOnly;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final String hintText;
  final double borderRadius;
  final String? Function(String? s)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      cursorColor: Colors.black,
      controller: controller,
      keyboardType: textInputType,
      style: robotoRegular.copyWith(fontSize: 13),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: robotoRegular.copyWith(color: AppColors.secondaryTxt),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          )),
      validator: validator,
    );
  }
}

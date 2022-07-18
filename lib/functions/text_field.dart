import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/functions/app_config.dart';

class CustomTextField extends StatelessWidget {
  final String? text, errorText;
  final Widget? prefixIcon, suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? hideText;
  final TextInputType? inputType;
  final double? verticalMargin;
  final double? horizontalMargin;

  const CustomTextField(
      {this.text,
      this.prefixIcon,
      this.controller,
      this.errorText,
      this.validator,
      this.suffixIcon,
      this.hideText,
      this.inputType,
      this.verticalMargin,
      this.horizontalMargin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: verticalMargin ?? 5,
        bottom: verticalMargin ?? 5,
        left: horizontalMargin ?? 5,
        right: horizontalMargin ?? 5,
      ),
      child: TextFormField(
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: hideText ?? false,
        controller: controller,
        keyboardType: inputType ?? TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppConfig.whiteColor,
          labelText: text,
          labelStyle: TextStyle(
            color: AppConfig.textColor,
              fontFamily: AppConfig.fontFamilyRegular
          ),
          errorText: errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';
typedef OnChanged = void Function(String)?;
typedef onValidator=String? Function(String?)?;
class CustomTextField extends StatelessWidget {
  final double? radius;
  final Color borderColor;
  final bool ? filled;
  final Color ?fillColor;
  final String ?hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final TextEditingController? controller;
  final OnChanged onChanged;
  final onValidator validator;
  final TextInputType? KeyboardType;

  final bool obscureText;
  const CustomTextField({super.key, this.radius, required this.borderColor,
    this.filled, this.fillColor,  this.hintText,  this.labelText,
    this.hintStyle, this.labelStyle, this.prefixIcon,
    this.maxLines=1, this.suffixIcon, this.controller,
    this.onChanged, this.validator, this.KeyboardType=TextInputType.text, this.obscureText=false});

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      style: TextStyle(
        color: AppColors.white,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        enabledBorder: _builtDecorationBorder(radius: radius ?? 16, borderColor: borderColor),
        focusedBorder: _builtDecorationBorder(radius: radius ?? 16, borderColor: borderColor),
        errorBorder: _builtDecorationBorder(radius: radius ?? 16, borderColor: AppColors.red),
        focusedErrorBorder: _builtDecorationBorder(radius: radius ?? 16, borderColor: AppColors.red),
        filled: filled,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      maxLines: maxLines,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: KeyboardType ,
      obscureText: obscureText,
      obscuringCharacter: '*',
    );
  }
  OutlineInputBorder _builtDecorationBorder({required double radius,required Color borderColor}){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        color: borderColor,
        width: 2.0,
      ),
    );
  }

}







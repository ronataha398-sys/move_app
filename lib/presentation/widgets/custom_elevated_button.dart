import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? radius;
  final Color? borderColor;
  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.backgroundColor,
      this.verticalPadding,
      this.horizontalPadding,
      this.radius,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? 0, horizontal: horizontalPadding ?? 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 16.0),
          side: BorderSide(
            color: borderColor ?? AppColors.transparentColor,
            width: 2.0,
          ),
        ),
        backgroundColor: backgroundColor ?? AppColors.transparentColor,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

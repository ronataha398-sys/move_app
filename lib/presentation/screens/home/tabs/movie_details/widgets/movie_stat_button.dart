import 'package:flutter/material.dart';
import 'package:movie_app/presentation/widgets/custom_elevated_button.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/app_styles.dart';

import 'package:movie_app/presentation/screens/home/size_config.dart';
class MovieStatButton extends StatelessWidget {
  final String assetPath;
  final String value;
  final double horizontalPadding;
  final double iconSpacing;
  final EdgeInsetsGeometry? margin;

  const MovieStatButton({
    super.key,
    required this.assetPath,
    required this.value,
    this.horizontalPadding = 10,
    this.iconSpacing = 10,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? SizeConfig.only(context, left: 12, right: 12),
      child: CustomElevatedButton(
        backgroundColor: AppColors.darkGray,
        verticalPadding: SizeConfig.h(context, 10),
        horizontalPadding: SizeConfig.w(context, horizontalPadding),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(assetPath),
            SizedBox(width: SizeConfig.w(context, iconSpacing)),
            Text(
              value,
              style: AppStyles.regular20White,
            ),
          ],
        ),
      ),
    );
  }
}

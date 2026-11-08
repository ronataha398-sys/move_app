import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_styles.dart';

import 'package:movie_app/presentation/screens/home/size_config.dart';
class MovieDetailsSectionTitle extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? padding;

  const MovieDetailsSectionTitle({
    super.key,
    required this.title,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? SizeConfig.only(context, left: 10, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.bold24White,
          ),
        ],
      ),
    );
  }
}

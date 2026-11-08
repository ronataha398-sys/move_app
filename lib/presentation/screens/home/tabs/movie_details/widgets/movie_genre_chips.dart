import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/app_styles.dart';

import 'package:movie_app/presentation/screens/home/size_config.dart';
class MovieGenreChips extends StatelessWidget {
  final List<String> genres;

  const MovieGenreChips({
    super.key,
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: SizeConfig.w(context, 8),
      runSpacing: SizeConfig.h(context, 8),
      children: genres.map((genre) {
        return Container(
          padding: SizeConfig.symmetric(context, vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.darkGray.withValues(alpha: .75),
            borderRadius: SizeConfig.circular(context, 12),
          ),
          child: Text(
            genre,
            style: AppStyles.regular16White,
          ),
        );
      }).toList(),
    );
  }
}

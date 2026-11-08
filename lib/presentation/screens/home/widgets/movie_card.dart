import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';

import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/presentation/screens/home/size_config.dart';

import '../tabs/movie_details/movie_details_screen.dart';

class MovieCard extends StatelessWidget {
  MovieCard({
    super.key,
    required this.movie,
  });

  final Movies movie;

  @override
  Widget build(BuildContext context) {
    final String posterImage = movie.mediumCoverImage ?? '';

    return Material(
      color: AppColors.transparentColor,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(movie: movie),
              ));
        },
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: SizeConfig.circular(context, 20),
              ),
              child: posterImage.isEmpty
                  ? Icon(
                Icons.broken_image,
                color: Colors.white,
              )
              :Image.network(
                posterImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                errorBuilder: (context, error, stackTrace) {
                  print('Image Error: $error');
                  return const Icon(
                    Icons.broken_image,
                    color: Colors.white,
                  );
                },
              ),            ),
            Container(
              margin: SizeConfig.all(context, 10),
              height: SizeConfig.h(context, 28),
              width: SizeConfig.w(context, 58),
              decoration: BoxDecoration(
                color: AppColors.darkGray.withValues(alpha: 0.75),
                borderRadius: SizeConfig.circular(context, 8),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: SizeConfig.only(context, left: 4),
                    child: Text(
                      movie.rating?.toString() ?? '0.0',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: SizeConfig.w(context, 16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Image.asset(
                    AppAssets.star,
                    height: SizeConfig.h(context, 15),
                    width: SizeConfig.w(context, 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
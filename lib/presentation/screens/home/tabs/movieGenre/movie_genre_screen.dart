import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';

import 'package:movie_app/core/utils/app_colors.dart';

import 'package:movie_app/presentation/screens/home/size_config.dart';

import '../../widgets/movie_card.dart';
class MovieGenreScreen extends StatelessWidget {
  final List<Movies> movies;
  final String genre;
  const MovieGenreScreen(
      {super.key, required this.movies, required this.genre});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          backgroundColor: AppColors.black,
          leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: SizeConfig.only(context, left: 8),
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.white,
              ),
            ),
          ),
          title: Text(
            genre,
            style: TextStyle(color: AppColors.white),
          ),
        ),
        body: Padding(
          padding: SizeConfig.all(context, 8),
          child: GridView.builder(
            itemCount: movies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: SizeConfig.w(context, 8),
              mainAxisSpacing: SizeConfig.h(context, 12),
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              return MovieCard(
                movie: movies[index],
              );
            },
          ),
        ),
      ),
    );
  }
}

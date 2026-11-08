import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';

import 'package:movie_app/presentation/widgets/genre_movie_list.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/app_styles.dart';

import 'package:movie_app/presentation/screens/home/size_config.dart';

import '../tabs/movieGenre/movie_genre_screen.dart';
class MovieGenre extends StatelessWidget {
  final List<Movies> movies;
  const MovieGenre({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final genres = <String>{};

    for (var item in movies) {
      genres.addAll(item.genres ?? []);
    }
    final genresList = genres.toList();

    return Padding(
      padding: SizeConfig.all(context, 8),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: genresList.length,
          itemBuilder: (context, index) {
            final currentGenre = genresList[index];
            final genreMovies = movies
                .where((item) => item.genres?.contains(currentGenre) ?? false)
                .toList();
            return Column(
              children: [
                SizedBox(height: SizeConfig.h(context, 10)),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      currentGenre,
                      style: AppStyles.regular20White,
                    )),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieGenreScreen(
                              movies: genreMovies,
                              genre: currentGenre,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "see more",
                        style: AppStyles.black14Yellow,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: AppColors.yellow,
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.h(context, 10)),
                GenreMovieList(
                  movies: genreMovies,
                ),
              ],
            );
          }),
    );
  }
}

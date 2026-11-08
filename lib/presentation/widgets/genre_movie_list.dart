import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';

import '../screens/home/widgets/movie_card.dart';


class GenreMovieList extends StatelessWidget {
  final List<Movies> movies;

  const GenreMovieList({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: movies.length,
      itemBuilder: (context, index, realIndex) {
        final movie = movies[index];

        return MovieCard(movie: movie);
      },
      options: CarouselOptions(
        viewportFraction: 0.45,
        aspectRatio: 16 / 10,
        enlargeCenterPage: false,
        enableInfiniteScroll: false,
        padEnds: false,
        scrollDirection: Axis.horizontal,
      ),
    );
    ;
  }
}

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/presentation/screens/home/size_config.dart';

import '../screens/home/widgets/movie_card.dart';
class MovieCarousel extends StatefulWidget {
  Function? onChangeImage;
  bool autoPlay;
  bool enlargeCenterPage;

  List<Movies>? movieList;
  MovieCarousel({
    super.key,
    this.onChangeImage,
    this.autoPlay = false,
    this.enlargeCenterPage = false,
    this.movieList,
  });

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  @override
  Widget build(BuildContext context) {
    final movies = widget.movieList ?? [];
    return Column(children: [
      SizedBox(
        height: SizeConfig.h(context, 250),
        child: CarouselSlider.builder(
          itemCount: movies.length,
          itemBuilder: (context, index, realIndex) {
            final movie = movies[index];

            return MovieCard(movie: movie);
          },
          options: CarouselOptions(
            height: SizeConfig.h(context, 250),
            autoPlay: widget.autoPlay,
            enlargeCenterPage: widget.enlargeCenterPage,
            viewportFraction: 0.5,
            initialPage: 0,
            clipBehavior: Clip.antiAlias,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 500),
            onPageChanged: (index, reason) {
              widget.onChangeImage?.call(movies[index].largeCoverImage ?? "");
            },
          ),
        ),
      ),
    ]);
  }
}

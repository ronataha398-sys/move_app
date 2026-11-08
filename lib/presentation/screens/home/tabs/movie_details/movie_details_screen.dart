import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/presentation/screens/home/size_config.dart';
import 'package:movie_app/presentation/screens/home/tabs/movie_details/widgets/cast_cart.dart';
import 'package:movie_app/presentation/screens/home/tabs/movie_details/widgets/movie_details_header.dart';
import 'package:movie_app/presentation/screens/home/tabs/movie_details/widgets/movie_details_section_title.dart';
import 'package:movie_app/presentation/screens/home/tabs/movie_details/widgets/movie_genre_chips.dart';
import 'package:movie_app/presentation/screens/home/tabs/movie_details/widgets/movie_stat_button.dart';

import 'package:movie_app/presentation/widgets/custom_elevated_button.dart';

import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/app_styles.dart';
import 'package:movie_app/data/datasourses/remote/firebase_utils.dart';



import '../../../../../presentation/bloc/detailes/details_bloc.dart';
import '../../../../../presentation/bloc/detailes/details_event.dart';
import '../../../../../presentation/bloc/detailes/details_state.dart';
import 'movie_similer.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movies movie;

  const MovieDetailsScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailsScreen> createState() =>
      _MovieDetailsScreenState();
}

class _MovieDetailsScreenState
    extends State<MovieDetailsScreen> {

  // =========================
  // SAVE / WISH LIST
  // =========================

  bool isSave = false;

  // =========================
  // TRAILER
  // =========================

  bool showTrailer = false;

  @override
  void initState() {
    super.initState();

    // Add movie to History
    _addToHistory();

    // Check if movie is already saved
    _checkIfSaved();
  }

  // =========================
  // HISTORY
  // =========================

  Future<void> _addToHistory() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    await FireBaseUtils.addMovieToHistory(
      userId: user.uid,
      movie: widget.movie,
    );
  }

  // =========================
  // CHECK IF SAVED
  // =========================

  Future<void> _checkIfSaved() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null || widget.movie.id == null) {
      return;
    }

    final saved = await FireBaseUtils.isMovieSaved(
      userId: user.uid,
      movieId: widget.movie.id!,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      isSave = saved;
    });
  }

  // =========================
  // SAVE / REMOVE FROM WISH LIST
  // =========================

  Future<void> _toggleSave() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    // Change icon immediately
    setState(() {
      isSave = !isSave;
    });

    try {
      if (isSave) {
        // ⭐ Add to Wish List
        await FireBaseUtils.addMovieToSave(
          userId: user.uid,
          movie: widget.movie,
        );
      } else {
        // ⭐ Remove from Wish List
        await FireBaseUtils.removeMovieFromSave(
          userId: user.uid,
          movie: widget.movie,
        );
      }
    } catch (e) {
      // If Firebase fails, return icon to previous state
      if (!mounted) {
        return;
      }

      setState(() {
        isSave = !isSave;
      });
    }
  }

  // =========================
  // WATCH MOVIE
  // =========================

  Future<void> _watchMovie() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    // ▶️ Add movie to Watch List
    await FireBaseUtils.addMovieToWatchList(
      userId: user.uid,
      movie: widget.movie,
    );

    if (!mounted) {
      return;
    }

    // Open trailer
    setState(() {
      showTrailer = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      DetailsBloc()
        ..add(
          GetDetailsEvent(
            id: widget.movie.id!,
          ),
        ),

      child: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {

          // =========================
          // LOADING
          // =========================

          if (state.status == DetailsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.yellow,
              ),
            );
          }

          // =========================
          // ERROR
          // =========================

          if (state.status == DetailsStatus.error) {
            return const Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          // =========================
          // SUCCESS
          // =========================

          if (state.status == DetailsStatus.success) {
            final detailMovie =
                state.movieDetails?.data?.movie;

            if (detailMovie == null) {
              return const Center(
                child: Text(
                  "Something went wrong",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }

            return SafeArea(
              child: Scaffold(
                backgroundColor:
                AppColors.transparentColor,

                body: SingleChildScrollView(
                  child: Column(
                    children: [

                      // ==========================================
                      // MOVIE HEADER
                      // ==========================================

                      MovieDetailsHeader(
                        movie: detailMovie,

                        // Back
                        onBackPressed: () {
                          Navigator.pop(context);
                        },

                        // ⭐ Save state
                        isSave: isSave,

                        // Trailer state
                        showTrailer: showTrailer,

                        // ▶️ Watch
                        onTrailerPressed: _watchMovie,

                        // ⭐ Save
                        onIsSavePressed: _toggleSave,
                      ),

                      // ==========================================
                      // WATCH BUTTON
                      // ==========================================

                      Padding(
                        padding: SizeConfig.all(
                          context,
                          8,
                        ),

                        child: Row(
                          children: [

                            Expanded(
                              child: CustomElevatedButton(
                                backgroundColor:
                                AppColors.red,

                                verticalPadding: 10,

                                onPressed: _watchMovie,

                                child: Text(
                                  'Watch',
                                  style:
                                  AppStyles
                                      .regular20White,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height:
                        SizeConfig.h(context, 5),
                      ),

                      // ==========================================
                      // STATS
                      // ==========================================

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,

                        children: [

                          MovieStatButton(
                            assetPath:
                            AppAssets.favorite,

                            value:
                            (detailMovie.likeCount ??
                                '')
                                .toString(),

                            horizontalPadding: 10,

                            iconSpacing: 10,
                          ),

                          MovieStatButton(
                            assetPath:
                            AppAssets.time,

                            value:
                            (detailMovie.runtime ??
                                '')
                                .toString(),

                            horizontalPadding: 15,

                            iconSpacing: 15,
                          ),

                          MovieStatButton(
                            assetPath:
                            AppAssets.star2,

                            value:
                            (detailMovie.rating ??
                                '')
                                .toString(),

                            horizontalPadding: 10,

                            iconSpacing: 10,
                          ),
                        ],
                      ),

                      SizedBox(
                        height:
                        SizeConfig.h(context, 5),
                      ),

                      // ==========================================
                      // SCREEN SHOTS
                      // ==========================================

                      MovieDetailsSectionTitle(
                        title: 'Screen Shots',

                        padding: SizeConfig.only(
                          context,
                          left: 10,
                          top: 15,
                          bottom: 15,
                        ),
                      ),

                      Container(
                        height:
                        SizeConfig.h(context, 200),

                        width: double.infinity,

                        margin: SizeConfig.only(
                          context,
                          right: 10,
                          left: 10,
                        ),

                        clipBehavior:
                        Clip.hardEdge,

                        decoration:
                        BoxDecoration(
                          borderRadius:
                          SizeConfig.circular(
                            context,
                            20,
                          ),
                        ),

                        child: Image.network(
                          detailMovie
                              .backgroundImage ??
                              '',
                          fit: BoxFit.cover,
                        ),
                      ),

                      // ==========================================
                      // SIMILAR
                      // ==========================================

                      MovieDetailsSectionTitle(
                        title: 'Similar ',

                        padding: SizeConfig.only(
                          context,
                          left: 10,
                          top: 15,
                          bottom: 5,
                        ),
                      ),

                      Padding(
                        padding: SizeConfig.only(
                          context,
                          right: 12,
                          left: 12,
                          top: 10,
                          bottom: 5,
                        ),

                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,

                          children: [
                            MovieSimiler(
                              movieId:
                              widget.movie.id!,
                            ),
                          ],
                        ),
                      ),

                      // ==========================================
                      // SUMMARY
                      // ==========================================

                      MovieDetailsSectionTitle(
                        title: 'Summary ',

                        padding: SizeConfig.only(
                          context,
                          left: 10,
                          top: 10,
                          bottom: 10,
                        ),
                      ),

                      Padding(
                        padding: SizeConfig.only(
                          context,
                          right: 12,
                          left: 12,
                          bottom: 5,
                        ),

                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,

                          children: [
                            Text(
                              detailMovie
                                  .descriptionIntro ??
                                  '',
                              style:
                              AppStyles
                                  .regular16White,
                            ),
                          ],
                        ),
                      ),

                      // ==========================================
                      // CAST
                      // ==========================================

                      MovieDetailsSectionTitle(
                        title: 'Cast',

                        padding: SizeConfig.only(
                          context,
                          left: 10,
                          top: 10,
                          bottom: 5,
                        ),
                      ),

                      Padding(
                        padding: SizeConfig.only(
                          context,
                          right: 10,
                          left: 10,
                          top: 10,
                          bottom: 5,
                        ),

                        child: CastCart(),
                      ),

                      // ==========================================
                      // GENRES
                      // ==========================================

                      MovieDetailsSectionTitle(
                        title: 'Genres',

                        padding: SizeConfig.only(
                          context,
                          left: 10,
                          top: 10,
                          bottom: 5,
                        ),
                      ),

                      Padding(
                        padding: SizeConfig.only(
                          context,
                          right: 12,
                          left: 12,
                          top: 5,
                          bottom: 20,
                        ),

                        child: SizedBox(
                          width: double.infinity,

                          child: MovieGenreChips(
                            genres:
                            detailMovie.genres ??
                                [],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
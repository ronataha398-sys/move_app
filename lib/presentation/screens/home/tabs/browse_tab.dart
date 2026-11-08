import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/screens/home/size_config.dart';

import 'package:movie_app/core/utils/app_colors.dart';


import '../../../../presentation/bloc/browse/browse_bloc.dart';
import '../../../../presentation/bloc/browse/browse_event.dart';
import '../../../bloc/browse/browse_state.dart';
import '../widgets/movie_card.dart';



class BrowseTab extends StatelessWidget {
  BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => BrowseBloc()..add(GetBrowseMoviesEvent()),
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: AppColors.black2,
              body: BlocBuilder<BrowseBloc, BrowseState>(
                builder: (context, state) {
                  // Loading
                  if (state is BrowseLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    );
                  }

                  // Error
                  if (state is BrowseError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }

                  // Success
                  if (state is BrowseSuccess) {
                    return Column(
                      children: [
                        // Genres
                        SizedBox(
                          height: SizeConfig.h(context, 55),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: SizeConfig.symmetric(context, horizontal: 10),
                            itemCount: state.genres.length,
                            itemBuilder: (context, index) {
                              final genre = state.genres[index];

                              final isSelected = genre == state.selectedGenre;

                              return GestureDetector(
                                onTap: () {
                                  context.read<BrowseBloc>().add(
                                        SelectGenreEvent(genre),
                                      );
                                },
                                child: Container(
                                  margin: SizeConfig.only(context, right: 10),
                                  padding: SizeConfig.symmetric(context, horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.yellow : Colors.transparent,
                                    border: Border.all(
                                      color: AppColors.yellow,
                                      width: SizeConfig.w(context, 2),
                                    ),
                                    borderRadius: SizeConfig.circular(context, 16),
                                  ),
                                  child: Center(
                                    child: Text(
                                      genre,
                                      style: TextStyle(
                                        color: isSelected ? AppColors.black : AppColors.yellow,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(height: SizeConfig.h(context, 15)),

                        // Movies
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              final filteredMovies = state.movies.where(
                                (movie) {
                                  return movie.genres?.contains(
                                        state.selectedGenre,
                                      ) ??
                                      false;
                                },
                              ).toList();

                              return GridView.builder(
                                padding: SizeConfig.symmetric(context, horizontal: 10),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: SizeConfig.w(context, 12),
                                  mainAxisSpacing: SizeConfig.h(context, 12),
                                ),
                                itemCount: filteredMovies.length,
                                itemBuilder: (context, index) {
                                  return MovieCard(
                                    movie: filteredMovies[index],
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        SizedBox(height: SizeConfig.h(context, 10)),
                      ],
                    );
                  }

                  return SizedBox();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
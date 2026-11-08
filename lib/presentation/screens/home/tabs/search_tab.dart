import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/presentation/screens/home/size_config.dart';


import '../../../../l10n/app_localizations.dart';
import '../../../../presentation/bloc/search/search_bloc.dart';
import '../../../../presentation/bloc/search/search_event.dart';
import '../../../../presentation/bloc/search/search_state.dart';
import '../widgets/movie_card.dart';

class SearchTab extends StatelessWidget {
  SearchTab({super.key});

  @override
  Widget build(BuildContext context) {

    final localizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: BlocProvider(
        create: (context) => SearchBloc()..add(GetMoviesEvent()),
        child: Builder(
          builder: (context) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColors.black2,
              body: SizedBox(
                height: SizeConfig.screenHeight(context),
                width: SizeConfig.screenWidth(context),
                child: Column(
                  children: [
                    Padding(
                      padding: SizeConfig.all(context, 10),
                      child: TextField(
                        onChanged: (value) {
                          context.read<SearchBloc>().add(
                            SearchMovieEvent(value),
                          );
                        },
                        style: TextStyle(
                          color: AppColors.yellow,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: SizeConfig.only(context, top: 10, left: 10, bottom: 10),
                            child: Image.asset(
                              AppAssets.searchTab,
                            ),
                          ),
                          fillColor: AppColors.darkGray,
                          filled: true,
                          hintText: localizations.search,
                          hintStyle: TextStyle(
                            color: AppColors.white,
                          ),
                          contentPadding: SizeConfig.symmetric(context, vertical: 15, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: SizeConfig.circular(context, 16),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          if (state is SearchLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is SearchError) {
                            return Center(
                              child: Text(
                                state.message,
                                style: TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                            );
                          }

                          if (state is SearchSuccess) {
                            if (state.movies.isEmpty) {
                              return Center(
                                child: Text(
                                  'No movies found',
                                  style: TextStyle(
                                    color: AppColors.white,
                                  ),
                                ),
                              );
                            }

                            return GridView.builder(
                              padding: SizeConfig.all(context, 10),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                    crossAxisSpacing: SizeConfig.w(context, 10),
                                    mainAxisSpacing: SizeConfig.h(context, 15),
                                childAspectRatio: 0.65,
                              ),
                              itemCount: state.movies.length,
                              itemBuilder: (context, index) {
                                final movie = state.movies[index];


                                return MovieCard(
                                  movie: movie,
                                );
                              },
                            );
                          }

                          return Center(
                            child: Image.asset(
                              AppAssets.emtySearch,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
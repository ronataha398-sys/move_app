import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:movie_app/presentation/widgets/movie_carousel.dart';
import 'package:movie_app/core/utils/app_assets.dart';

import 'package:movie_app/presentation/screens/home/size_config.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../presentation/bloc/home/home_bloc.dart';
import '../../../../presentation/bloc/home/home_event.dart';
import '../../../../presentation/bloc/home/home_state.dart';
import '../widgets/movie_genre.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeInitialEvent()),
      child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.status == HomeStatus.loading) {
              return Center(
                  child: CircularProgressIndicator(
                color: AppColors.yellow,
              ));
            }
            if (state.status == HomeStatus.error) {
              return Center(
                  child: Text("Something went wrong",
                      style: TextStyle(color: Colors.white)));
            }

            if (state.status == HomeStatus.success) {
              final listmovies = state.movie?.data?.movies ?? [];

              return SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: SizeConfig.h(context, 465),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 400),
                              child: state.backgroundImage != null
                                  ? SizedBox.expand(
                                      child: Image.network(
                                        state.backgroundImage!,
                                        key: ValueKey<String>(
                                            state.backgroundImage!),
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                          AppAssets.mainLay,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )
                                  : Image.asset(
                                      AppAssets.overLayer5,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.black2.withValues(alpha: 0.60),
                                    AppColors.black2.withValues(alpha: 0.95),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: SizeConfig.h(context, 120),
                                child: Center(
                                  child: Image.asset(
                                    AppAssets.availableNow,
                                    fit: BoxFit.contain,
                                    width: SizeConfig.w(context, 180),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.h(context, 260),
                                child: MovieCarousel(
                                  movieList: listmovies,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  onChangeImage: (Image) {
                                    context.read<HomeBloc>().add(
                                        ChangeBackgroundImageEvent(
                                            image: Image));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.h(context, 80),
                                child: Center(
                                  child: Image.asset(
                                    AppAssets.watchNow,
                                    fit: BoxFit.contain,
                                    width: SizeConfig.w(context, 245),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    MovieGenre(movies: listmovies),
                  ],
                ),
              ));
            }
            return const SizedBox();
          }),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:movie_app/presentation/screens/home/size_config.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/data/models/movie_model.dart';

import 'package:movie_app/presentation/widgets/custom_elevated_button.dart';


import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/core/utils/app_styles.dart';

import '../../../../presentation/bloc/profile/profile_event.dart';
import '../../../../presentation/bloc/profile/profile_state.dart';
import '../../../../presentation/bloc/profile/proflie_bloc.dart';
import '../../../../presentation/bloc/user/user_bloc.dart';
import '../../../../presentation/bloc/user/user_event.dart';
import '../../../../presentation/bloc/user/user_state.dart';
import '../widgets/movie_card.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      context.read<ProfileBloc>().add(
        LoadProfileEvent(user.uid),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
    AppLocalizations.of(context)!;

    final userState =
        context.watch<UserBloc>().state;

    final user =
        FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor:
          const Color.fromRGBO(40, 42, 40, 1),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, profileState) {
              return NestedScrollView(
                headerSliverBuilder:
                    (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: SizeConfig.only(
                          context,
                          top: 24,
                          left: 24,
                          right: 10,
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // =========================
                                // PROFILE IMAGE + NAME
                                // =========================
                                Column(
                                  children: [
                                    Image.asset(
                                      AppAssets.avatar_1,
                                      height: SizeConfig.h(
                                        context,
                                        100,
                                      ),
                                      width: SizeConfig.w(
                                        context,
                                        100,
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.h(
                                        context,
                                        15,
                                      ),
                                    ),
                                    Text(
                                      userState
                                      is UserSuccess
                                          ? userState.user.name
                                          : '',
                                      style: AppStyles
                                          .roboto20White500,
                                    ),
                                  ],
                                ),

                                // =========================
                                // WISH LIST COUNT
                                // =========================
                                Padding(
                                  padding: SizeConfig.only(
                                    context,
                                    left: 20,
                                    right: 15,
                                  ),
                                  child: Column(
                                    children: [
                                      _buildWishListCount(
                                        profileState,
                                      ),
                                      SizedBox(
                                        height:
                                        SizeConfig.h(
                                          context,
                                          10,
                                        ),
                                      ),
                                       Text(
                                        'Wish List',
                                        style: AppStyles
                                            .regular20White,
                                      ),
                                    ],
                                  ),
                                ),

                                // =========================
                                // HISTORY COUNT
                                // =========================
                                Column(
                                  children: [
                                    _buildHistoryCount(
                                      profileState,
                                    ),
                                    SizedBox(
                                      height:
                                      SizeConfig.h(
                                        context,
                                        10,
                                      ),
                                    ),
                                    Text(
                                      localizations.history,
                                      style: AppStyles
                                          .regular20White,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // =========================
                            // EDIT PROFILE + LOGOUT
                            // =========================
                            Padding(
                              padding: SizeConfig.only(
                                context,
                                top: 24,
                                right: 10,
                                bottom: 24,
                              ),
                              child: Row(
                                children: [
                                  // EDIT PROFILE
                                  Expanded(
                                    flex: 2,
                                    child:
                                    CustomElevatedButton(
                                      backgroundColor:
                                      AppColors.yellow,
                                      radius:
                                      SizeConfig.w(
                                        context,
                                        15,
                                      ),
                                      verticalPadding:
                                      SizeConfig.h(
                                        context,
                                        15,
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes
                                              .update_profile,
                                        );
                                      },
                                      child: Text(
                                        localizations
                                            .edit_profile,
                                        style: AppStyles
                                            .regular20DarkGray,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width: SizeConfig.w(
                                      context,
                                      10,
                                    ),
                                  ),

                                  // LOGOUT
                                  Expanded(
                                    flex: 1,
                                    child:
                                    CustomElevatedButton(
                                      backgroundColor:
                                      AppColors.red,
                                      radius:
                                      SizeConfig.w(
                                        context,
                                        15,
                                      ),
                                      verticalPadding:
                                      SizeConfig.h(
                                        context,
                                        15,
                                      ),
                                      onPressed: () async {
                                        await FirebaseAuth
                                            .instance
                                            .signOut();

                                        if (!context.mounted) {
                                          return;
                                        }

                                        context
                                            .read<UserBloc>()
                                            .add(
                                          ClearUserEvent(),
                                        );

                                        Navigator
                                            .pushNamedAndRemoveUntil(
                                          context,
                                          AppRoutes
                                              .login_screen,
                                              (route) => false,
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          Text(
                                            localizations.exit,
                                            style: AppStyles
                                                .regular20White,
                                          ),
                                          SizedBox(
                                            width:
                                            SizeConfig.w(
                                              context,
                                              8,
                                            ),
                                          ),
                                          const Icon(
                                            Icons
                                                .exit_to_app_outlined,
                                            color:
                                            AppColors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // =========================
                    // TABS
                    // =========================
                    SliverPersistentHeader(
                      pinned: true,
                      delegate:
                      _SliverTabBarDelegate(
                        TabBar(
                          indicatorColor:
                          AppColors.yellow,
                          dividerColor:
                          AppColors.transparentColor,
                          unselectedLabelColor:
                          AppColors.transparentColor,
                          tabs: [
                            // WATCH LIST
                            Tab(
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.list,
                                    color:
                                    AppColors.yellow,
                                  ),
                                  Text(
                                    localizations
                                        .watch_list,
                                    style: AppStyles
                                        .regular14White,
                                  ),
                                ],
                              ),
                            ),

                            // HISTORY
                            Tab(
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.folder,
                                    color:
                                    AppColors.yellow,
                                  ),
                                  Text(
                                    localizations.history,
                                    style: AppStyles
                                        .regular14White,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },

                // =========================
                // TAB CONTENT
                // =========================
                body: _buildTabView(
                  user: user,
                  profileState: profileState,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // =========================
  // WISH LIST COUNT
  // =========================
  Widget _buildWishListCount(
      ProfileState state,
      ) {
    if (state is ProfileLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: AppColors.yellow,
          strokeWidth: 2,
        ),
      );
    }

    if (state is ProfileSuccess) {
      return Text(
        state.wishListCount.toString(),
        style: AppStyles.bold24White,
      );
    }

    return Text(
      '0',
      style: AppStyles.bold24White,
    );
  }

  // =========================
  // HISTORY COUNT
  // =========================
  Widget _buildHistoryCount(
      ProfileState state,
      ) {
    if (state is ProfileLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: AppColors.yellow,
          strokeWidth: 2,
        ),
      );
    }

    if (state is ProfileSuccess) {
      return Text(
        state.history.length.toString(),
        style: AppStyles.bold24White,
      );
    }

    return Text(
      '0',
      style: AppStyles.bold24White,
    );
  }

  // =========================
  // TAB VIEW
  // =========================
  Widget _buildTabView({
    required User? user,
    required ProfileState profileState,
  }) {
    if (user == null) {
      return TabBarView(
        children: [
          Container(
            color: AppColors.black2,
            child: _loginMessage(),
          ),
          Container(
            color: AppColors.black2,
            child: _loginMessage(),
          ),
        ],
      );
    }

    if (profileState is ProfileLoading ||
        profileState is ProfileInitial) {
      return const TabBarView(
        children: [
          Center(
            child: CircularProgressIndicator(
              color: AppColors.yellow,
            ),
          ),
          Center(
            child: CircularProgressIndicator(
              color: AppColors.yellow,
            ),
          ),
        ],
      );
    }

    if (profileState is ProfileError) {
      return TabBarView(
        children: [
          Container(
            color: AppColors.black2,
            child: _errorMessage(),
          ),
          Container(
            color: AppColors.black2,
            child: _errorMessage(),
          ),
        ],
      );
    }

    if (profileState is ProfileSuccess) {
      return TabBarView(
        children: [
          // =========================
          // WATCH LIST
          // =========================
          Container(
            color: AppColors.black2,
            child: profileState.watchList.isEmpty
                ? _emptyImage()
                : _movieGrid(
              profileState.watchList,
            ),
          ),

          // =========================
          // HISTORY
          // =========================
          Container(
            color: AppColors.black2,
            child: profileState.history.isEmpty
                ? _emptyImage()
                : _movieGrid(
              profileState.history,
            ),
          ),
        ],
      );
    }

    return const TabBarView(
      children: [
        SizedBox(),
        SizedBox(),
      ],
    );
  }

  // =========================
  // MOVIE GRID
  // =========================
  Widget _movieGrid(List<Movies> movies) {
    return GridView.builder(
      padding: SizeConfig.all(
        context,
        10,
      ),
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing:
        SizeConfig.w(
          context,
          12,
        ),
        mainAxisSpacing:
        SizeConfig.h(
          context,
          12,
        ),
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieCard(
          movie: movies[index],
        );
      },
    );
  }

  // =========================
  // EMPTY
  // =========================
  Widget _emptyImage() {
    return Center(
      child: Image.asset(
        AppAssets.emtySearch,
      ),
    );
  }

  // =========================
  // LOGIN MESSAGE
  // =========================
  Widget _loginMessage() {
    return Center(
      child: Text(
        "Please login first",
        style: AppStyles.regular16White,
      ),
    );
  }

  // =========================
  // ERROR MESSAGE
  // =========================
  Widget _errorMessage() {
    return Center(
      child: Text(
        "Something went wrong",
        style: AppStyles.regular16White,
      ),
    );
  }
}

// =========================
// SLIVER TAB BAR DELEGATE
// =========================
class _SliverTabBarDelegate
    extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Container(
      color: AppColors.black2,
      child: tabBar,
    );
  }

  @override
  double get maxExtent =>
      tabBar.preferredSize.height;

  @override
  double get minExtent =>
      tabBar.preferredSize.height;

  @override
  bool shouldRebuild(
      covariant _SliverTabBarDelegate oldDelegate,
      ) {
    return false;
  }
}
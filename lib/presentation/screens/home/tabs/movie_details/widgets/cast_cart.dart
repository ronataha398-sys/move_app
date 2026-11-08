import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/app_styles.dart';
import 'package:movie_app/presentation/screens/home/size_config.dart';

import '../../../../../../presentation/bloc/detailes/details_bloc.dart';
import '../../../../../../presentation/bloc/detailes/details_state.dart';

class CastCart extends StatelessWidget {
  CastCart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsBloc, DetailsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == DetailsStatus.loading) {
          return Center(
              child: CircularProgressIndicator(
            color: AppColors.yellow,
          ));
        }
        if (state.status == DetailsStatus.error) {
          return Center(
              child: Text("Something went wrong",
                  style: TextStyle(color: Colors.white)));
        }

        if (state.status == DetailsStatus.success) {
          final cast = state.movieDetails?.data?.movie?.cast ?? [];

          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisExtent: SizeConfig.h(context, 90),
                  crossAxisSpacing: SizeConfig.w(context, 5),
                  mainAxisSpacing: SizeConfig.h(context, 10)),
              itemCount: cast.length,
              itemBuilder: (context, index) {
                final actor = cast[index];
                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: AppColors.darkGray.withValues(alpha: 0.75),
                      borderRadius: SizeConfig.circular(context, 16)),
                  padding:
                      SizeConfig.symmetric(context, vertical: 6, horizontal: 8),
                  child: Row(
                    children: [
                      if (actor.urlSmallImage != null &&
                          actor.urlSmallImage!.isNotEmpty)
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: SizeConfig.circular(context, 16)),
                          child: Image.network(
                            actor.urlSmallImage!,
                            height: SizeConfig.h(context, 50),
                            width: SizeConfig.w(context, 50),
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        Icon(
                          Icons.person,
                          color: Colors.white,
                          size: SizeConfig.h(context, 50),
                        ),
                      SizedBox(
                        width: SizeConfig.w(context, 10),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name : ${actor.name ?? ''}',
                              style: AppStyles.regular14White,
                            ),
                            SizedBox(
                              height: SizeConfig.h(context, 5),
                            ),
                            Text(
                              'Character : ${actor.characterName ?? ''}',
                              style: AppStyles.regular14White,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        }
        return const SizedBox();
      },
    );
  }
}

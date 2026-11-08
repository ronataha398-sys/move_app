import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_details_model.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/app_styles.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:movie_app/presentation/screens/home/size_config.dart';
class MovieDetailsHeader extends StatefulWidget {
  final Movie movie;
  final VoidCallback onBackPressed;
  final VoidCallback onIsSavePressed;
  final bool isSave;
  final bool showTrailer;
  final VoidCallback onTrailerPressed;
  const MovieDetailsHeader({
    super.key,
    required this.movie,
    required this.onBackPressed,
    required this.onIsSavePressed,
    required this.isSave,
    required this.showTrailer,
    required this.onTrailerPressed,
  });

  @override
  State<MovieDetailsHeader> createState() => _MovieDetailsHeaderState();
}

class _MovieDetailsHeaderState extends State<MovieDetailsHeader> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController();
    controller.loadVideoById(videoId: widget.movie.ytTrailerCode!);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.h(context, 560),
      width: double.infinity,
      child: Stack(
        children: [
          widget.showTrailer
              ? Padding(
                  padding: SizeConfig.only(context, top: 50),
                  child: SizedBox(
                      width: double.infinity,
                      height: SizeConfig.h(context, 560),
                      child: YoutubePlayer(controller: controller)),
                )
              : Image.network(widget.movie.largeCoverImage ?? ""),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.black2.withValues(alpha: 0.20),
                  AppColors.black2,
                ],
              ),
            ),
          ),
          if (!widget.showTrailer)
            InkWell(
                onTap: widget.onTrailerPressed,
                child: Center(child: Image.asset(AppAssets.play))),
          Padding(
            padding: SizeConfig.only(context, left: 20, top: 10, right: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: widget.onBackPressed,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                  ),
                ),
                Spacer(),
                InkWell(
                    onTap: widget.onIsSavePressed,
                    child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            widget.isSave ? AppColors.yellow : AppColors.white,
                            BlendMode.srcIn),
                        child: Image.asset(AppAssets.save))),
              ],
            ),
          ),
          if (!widget.showTrailer)
            Padding(
              padding: SizeConfig.all(context, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      widget.movie.titleEnglish ?? "",
                      style: AppStyles.medium36White,
                    ),
                  ),
                  Text(
                    (widget.movie.year ?? "").toString(),
                    style: AppStyles.regular20Gray,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

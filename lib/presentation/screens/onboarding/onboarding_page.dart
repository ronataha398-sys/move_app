import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/size_utils.dart';


import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import 'on_boarding_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final int pageIndex;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.onNext,
    required this.onBack,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          data.backgroundImage,
          fit: BoxFit.cover,
        ),



     if (data.overlayImage != null)
          Opacity(
            opacity: 0.9,
            child: Image.asset(
              data.overlayImage!,
              fit: BoxFit.cover,
            ),
          ),


        // Bottom Black Container
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.02,
            ),
            decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: pageIndex == 0
                      ? AppStyles.medium36White
                      : AppStyles.bold24White,
                ),

                if (data.description.isNotEmpty) ...[
                  const SizedBox(height: 14),

                  Text(
                    data.description,
                    textAlign: TextAlign.center,
                    style: pageIndex == 0
                        ? AppStyles.regular20Gray
                        : AppStyles.regular20White,
                  ),
                ],

                SizedBox(height: height * 0.02),

                // Main Button
                SizedBox(
                  width: double.infinity,
                  height: height * 0.05,
                  child: ElevatedButton(
                    onPressed: onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellow,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      data.buttonText,
                      style: AppStyles.semiBold20Black,
                    ),
                  ),
                ),

                // Back Button
                if (pageIndex > 1) ...[
                  SizedBox(height: height * 0.01),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.05,
                    child: OutlinedButton(
                      onPressed: onBack,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        side: const BorderSide(
                          color: AppColors.white,
                        ),
                      ),
                      child: Text(
                        'Back',
                        style: AppStyles.semiBold20Yellow,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
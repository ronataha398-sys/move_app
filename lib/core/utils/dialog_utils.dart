
import 'package:flutter/material.dart';
import '../../presentation/screens/home/size_config.dart';
import 'app_colors.dart';
import 'app_styles.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String loadingText,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.darkGray,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: context.width * 0.04,
            children: [
              CircularProgressIndicator(
                color: AppColors.yellow,
              ),
              Text(
                loadingText,
                style: AppStyles.regular16White,
              ),
            ],
          ),
        );
      },
    );
  }

  static void hideLoadong({
    required BuildContext context,
  }) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? title = '',
    String? posActionName,
    String? negActionName,
    VoidCallback? posAction,
    VoidCallback? negAction,
  }) {
    List<Widget> actions = [];

    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posActionName,
            style: AppStyles.semiBold20Yellow,
          ),
        ),
      );
    }

    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(
            negActionName,
            style: AppStyles.semiBold20Yellow,
          ),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkGray,
        content: Text(
          message,
          style: AppStyles.regular16White,
        ),
        title: Text(
          title!,
          style: AppStyles.semiBold20Yellow,
        ),
        actions: actions,
      ),
    );
  }
}

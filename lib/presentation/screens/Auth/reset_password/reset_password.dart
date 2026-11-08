import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/utils/size_utils.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.yellow,
        ),
        backgroundColor: AppColors.black,
        title: Text(
          localizations.forget_password,
          style: AppStyles.regular14Yellow,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.04,
            vertical: height * 0.02,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.forgetPassword,
                ),

                SizedBox(height: height * 0.02),

                CustomTextField(
                  controller: emailController,
                  KeyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter an email';
                    }

                    if (!RegExp(
                      r'^[\w.-]+@([\w-]+\.)+[\w-]{2,}$',
                    ).hasMatch(text.trim())) {
                      return 'Please enter a valid email address';
                    }

                    return null;
                  },
                  borderColor: AppColors.transparentColor,
                  filled: true,
                  fillColor: AppColors.darkGray,
                  hintText: localizations.email,
                  hintStyle: AppStyles.regular16White,
                  prefixIcon: const Icon(
                    Icons.email_rounded,
                    color: AppColors.white,
                  ),
                ),

                SizedBox(height: height * 0.02),

                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    onPressed: isLoading ? null : resetPassword,
                    verticalPadding: height * 0.01,
                    backgroundColor: AppColors.yellow,
                    child: Text(
                      localizations.verify_email,
                      style: AppStyles.regular20DarkGray,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    if (isLoading) return;

    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      DialogUtils.showLoading(
        context: context,
        loadingText: 'Sending reset email...',
      );

      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      if (!mounted) return;

      DialogUtils.hideLoadong(context: context);

      DialogUtils.showMessage(
        context: context,
        message:
        'Password reset email sent successfully. Please check your email.',
        posActionName: 'OK',
        posAction: () {
          Navigator.of(context).pushReplacementNamed(
            AppRoutes.login_screen,
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      DialogUtils.hideLoadong(context: context);

      String message = 'Something went wrong. Please try again.';

      if (e.code == 'user-not-found') {
        message = 'No account found with this email.';
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email address.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many requests. Please try again later.';
      } else if (e.code == 'network-request-failed') {
        message = 'Please check your internet connection.';
      }

      DialogUtils.showMessage(
        context: context,
        message: message,
        posActionName: 'OK',
      );
    } catch (e) {
      if (!mounted) return;

      DialogUtils.hideLoadong(context: context);

      DialogUtils.showMessage(
        context: context,
        message: 'Something went wrong. Please try again.',
        posActionName: 'OK',
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}

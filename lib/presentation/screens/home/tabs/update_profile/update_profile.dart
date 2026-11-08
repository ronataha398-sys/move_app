import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/presentation/widgets/custom_elevated_button.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/core/utils/app_styles.dart';
import 'package:movie_app/data/models/my_user.dart';
import 'package:movie_app/presentation/screens/home/size_config.dart';

import '../../../../../l10n/app_localizations.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String selectedAvatar = AppAssets.avatar_1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  // Get user data from Firestore
  Future<void> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection(MyUser.collectionName)
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data();

        if (!mounted) return;

        setState(() {
          nameController.text = data?['name'] ?? '';
          phoneController.text = data?['phone'] ?? '';
          selectedAvatar = data?['avatar'] ?? AppAssets.avatar_1;
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading profile: $e'),
        ),
      );
    }
  }

  // Update user data
  Future<void> updateProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection(MyUser.collectionName)
          .doc(user.uid)
          .update({
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'avatar': selectedAvatar,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating profile: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Choose avatar
  Future<void> chooseAvatar() async {
    final avatar = await showModalBottomSheet<String>(
      backgroundColor: AppColors.transparentColor,
      context: context,
      builder: (context) {
        return Padding(
          padding: SizeConfig.symmetric(
            context,
            vertical: 15,
            horizontal: 14,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.darkGray,
              borderRadius: SizeConfig.circular(context, 20),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: AppAssets.listUpdatProfile.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: SizeConfig.w(context, 10),
                mainAxisSpacing: SizeConfig.h(context, 10),
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: AppColors.transparentColor,
                  highlightColor: AppColors.transparentColor,
                  onTap: () {
                    Navigator.pop(
                      context,
                      AppAssets.listUpdatProfile[index],
                    );
                  },
                  child: Container(
                    margin: SizeConfig.all(context, 8),
                    padding: SizeConfig.all(context, 10),
                    decoration: BoxDecoration(
                      borderRadius: SizeConfig.circular(context, 20),
                      border: Border.all(
                        color: AppColors.yellow,
                        width: SizeConfig.w(context, 1),
                      ),
                    ),
                    child: Image.asset(
                      AppAssets.listUpdatProfile[index],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );

    if (avatar != null && mounted) {
      setState(() {
        selectedAvatar = avatar;
      });
    }
  }

  // Delete account
  Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection(MyUser.collectionName)
          .doc(user.uid)
          .delete();

      await user.delete();

      if (!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.login_screen,
            (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      if (e.code == 'requires-recent-login') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'For security, please log in again and then delete your account.',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.message}'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting account: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.transparentColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        elevation: 0,
        leading: InkWell(
          splashColor: AppColors.transparentColor,
          highlightColor: AppColors.transparentColor,
          onTap: () {
            Navigator.pop(
              context,
              AppRoutes.bottom_bar,
            );
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.yellow,
          ),
        ),
        title: Center(
          child: Text(
            localizations.pick_avatar,
            style: AppStyles.regular14Yellow,
          ),
        ),
        actions: [
          SizedBox(
            width: SizeConfig.w(context, 39),
          ),
        ],
      ),

      // Scrollable screen to avoid keyboard overflow
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: SizeConfig.only(context, top: 39),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar
                InkWell(
                  splashColor: AppColors.transparentColor,
                  highlightColor: AppColors.transparentColor,
                  onTap: chooseAvatar,
                  child: Center(
                    child: SizedBox(
                      height: SizeConfig.h(context, 168.8),
                      width: SizeConfig.w(context, 156),
                      child: Image.asset(
                        selectedAvatar,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                // Name
                Padding(
                  padding: SizeConfig.only(
                    context,
                    top: 33.76,
                    right: 7.8,
                    left: 7.8,
                  ),
                  child: TextField(
                    controller: nameController,
                    cursorColor: AppColors.yellow,
                    style: const TextStyle(
                      color: AppColors.yellow,
                    ),
                    decoration: InputDecoration(
                      fillColor: AppColors.darkGray,
                      filled: true,
                      prefixIcon: Image.asset(AppAssets.user),
                      hintText: localizations.name,
                      hintStyle: AppStyles.roboto20White500,
                      contentPadding: SizeConfig.symmetric(
                        context,
                        vertical: 16.88,
                        horizontal: 15.6,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: SizeConfig.circular(context, 15),
                        borderSide: BorderSide(
                          color: AppColors.darkGray,
                          width: SizeConfig.w(context, 1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: SizeConfig.circular(context, 15),
                        borderSide: BorderSide(
                          color: AppColors.yellow,
                          width: SizeConfig.w(context, 1),
                        ),
                      ),
                    ),
                  ),
                ),

                // Phone
                Padding(
                  padding: SizeConfig.only(
                    context,
                    top: 33.76,
                    right: 7.8,
                    left: 7.8,
                  ),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    cursorColor: AppColors.yellow,
                    style: const TextStyle(
                      color: AppColors.yellow,
                    ),
                    decoration: InputDecoration(
                      fillColor: AppColors.darkGray,
                      filled: true,
                      prefixIcon: Image.asset(AppAssets.phone),
                      hintText: '01200000000',
                      hintStyle: const TextStyle(
                        color: AppColors.white,
                      ),
                      contentPadding: SizeConfig.symmetric(
                        context,
                        vertical: 16.88,
                        horizontal: 7.8,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: SizeConfig.circular(context, 15),
                        borderSide: BorderSide(
                          color: AppColors.darkGray,
                          width: SizeConfig.w(context, 1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: SizeConfig.circular(context, 15),
                        borderSide: BorderSide(
                          color: AppColors.yellow,
                          width: SizeConfig.w(context, 1),
                        ),
                      ),
                    ),
                  ),
                ),

                // Reset Password
                Padding(
                  padding: SizeConfig.only(
                    context,
                    top: 25.32,
                    right: 7.8,
                    left: 7.8,
                    bottom: 33.76,
                  ),
                  child: Text(
                    localizations.reset_password,
                    style: AppStyles.regular20White,
                  ),
                ),

                // Delete Account
                Container(
                  margin: SizeConfig.symmetric(
                    context,
                    horizontal: 7.8,
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            backgroundColor: AppColors.red,
                            radius: SizeConfig.w(context, 15),
                            verticalPadding: SizeConfig.h(context, 15),
                            onPressed: isLoading ? null : deleteAccount,
                            child: Text(
                              localizations.delete_account,
                              style: AppStyles.regular20DarkGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: SizeConfig.h(context, 15),
                ),

                // Edit Profile
                Container(
                  margin: SizeConfig.symmetric(
                    context,
                    horizontal: 10,
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            backgroundColor: AppColors.yellow,
                            radius: SizeConfig.w(context, 15),
                            verticalPadding: SizeConfig.h(context, 15),
                            horizontalPadding: SizeConfig.w(context, 5),
                            onPressed: isLoading ? null : updateProfile,
                            child: isLoading
                                ? SizedBox(
                              height: SizeConfig.h(context, 33.76),
                              width: SizeConfig.w(context, 33.76),
                              child: const CircularProgressIndicator(
                                color: AppColors.darkGray,
                                strokeWidth: 2,
                              ),
                            )
                                : Text(
                              localizations.edit_profile,
                              style: AppStyles.regular20DarkGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: SizeConfig.h(context, 33.76),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

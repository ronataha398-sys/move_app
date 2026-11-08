// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:movie_app/l10n/app_localizations.dart';
// import 'package:movie_app/utils/app_routes.dart';
// import 'package:movie_app/utils/size_utils.dart';
// import 'package:provider/provider.dart';
// import '../../../../bloc/language/language_bloc.dart';
// import '../../../../bloc/language/language_event.dart';
// import '../../../../provider/user_provider.dart';
// import '../../../../utils/app_assets.dart';
// import '../../../../utils/app_colors.dart';
// import '../../../../utils/app_styles.dart';
// import '../../../../utils/dialog_utils.dart';
// import '../../../../utils/firebase_utils.dart';
// import '../../../widgets/custom_elevated_button.dart';
// import '../../../widgets/custom_text_field.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// class LoginScreen extends StatefulWidget {
//   LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   int selectedIndex = 1;
//   int selectedLanguage = 0;
//
//   var emailController = TextEditingController();
//   var passwordController = TextEditingController();
//   var formKey=GlobalKey<FormState>();
//
//
//   @override
//   Widget build(BuildContext context) {
//     var width = context.width;
//     var height = context.height;
//
//     final localizations = AppLocalizations.of(context)!;
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColors.black,
//         body: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: width * 0.04,
//             vertical: height * 0.02,
//           ),
//           child: SingleChildScrollView(
//             child: Form(
//               key: formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 spacing: height * 0.02,
//                 children: [
//                   Image.asset(AppAssets.movieLogo),
//
//                   SizedBox(
//                     height: height * 0.03,
//                   ),
//
//                   CustomTextField(
//                     controller: emailController,
//                     KeyboardType: TextInputType.emailAddress,
//                     validator: (text) {
//                       if (text == null || text.trim().isEmpty) {
//                         return 'Please Enter an email';
//                       }
//                       if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)) {
//                         return 'Please enter a valid email address';
//                       }
//                       return null;
//                     },
//
//
//                     borderColor: AppColors.transparentColor,
//                     filled: true,
//                     fillColor: AppColors.darkGray,
//                     hintText: localizations.email,
//                     hintStyle: AppStyles.regular16White,
//                     prefixIcon: Icon(
//                       Icons.email_rounded,
//                       color: AppColors.white,
//                     ),
//                   ),
//
//                   CustomTextField(
//                     controller: passwordController,
//                     obscureText: true,
//                     validator: (password) {
//                       if (password == null || password.trim().isEmpty) {
//                         return 'Please Enter a Password';
//                       }
//                       if (password.length < 6) {
//                         return 'Password must be at least 6 characters long';
//                       }
//                       return null;
//                     },
//                     borderColor: AppColors.transparentColor,
//                     filled: true,
//                     fillColor: AppColors.darkGray,
//                     hintText: localizations.password,
//                     hintStyle: AppStyles.regular16White,
//                     prefixIcon: Icon(
//                       Icons.lock,
//                       color: AppColors.white,
//                     ),
//                     suffixIcon: Icon(
//                       Icons.visibility_off_rounded,
//                       color: AppColors.white,
//                     ),
//                   ),
//
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pushNamed(
//                         AppRoutes.reset_password,
//                       );
//                     },
//                     child: Align(
//                       alignment: AlignmentDirectional.centerEnd,
//                       child: Text(
//                         localizations.forget_password,
//                         style: AppStyles.regular14Yellow,
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(
//                     width: double.infinity,
//                     child: CustomElevatedButton(
//                       onPressed: login,
//                       verticalPadding: height * 0.01,
//                       backgroundColor: AppColors.yellow,
//                       child: Text(
//                         localizations.login,
//                         style: AppStyles.regular20DarkGray,
//                       ),
//                     ),
//                   ),
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         localizations.dont_have_an_account,
//                         style: AppStyles.regular14White,
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pushNamed(
//                             AppRoutes.register_screen,
//                           );
//                         },
//                         child: Align(
//                           alignment: AlignmentDirectional.center,
//                           child: Text(
//                             localizations.create_one,
//                             style: AppStyles.black14Yellow,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Divider(
//                           thickness: 2,
//                           color: AppColors.yellow,
//                           indent: width * 0.01,
//                           endIndent: width * 0.04,
//                         ),
//                       ),
//
//                       Text(
//                         localizations.or,
//                         style: AppStyles.regular15Yellow,
//                       ),
//
//                       Expanded(
//                         child: Divider(
//                           thickness: 2,
//                           color: AppColors.yellow,
//                           indent: width * 0.01,
//                           endIndent: width * 0.04,
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   SizedBox(
//                     width: double.infinity,
//                     child: CustomElevatedButton(
//                       onPressed: () => signInWithGoogle(context),
//                       verticalPadding: height * 0.02,
//                       backgroundColor: AppColors.yellow,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         spacing: width * 0.04,
//                         children: [
//                           Image.asset(AppAssets.googleLogo),
//                           Text(
//                             localizations.login_with_google,
//                             style: AppStyles.regular16DarkGray,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//
//                   Container(
//                     width: 130,
//                     height: 62,
//                     padding: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: AppColors.yellow,
//                         width: 3,
//                       ),
//                       borderRadius: BorderRadius.circular(35),
//                     ),
//                     child: Stack(
//                       children: [
//                         // English flag
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedLanguage = 0;
//                               });
//
//                               context.read<LanguageBloc>().add(
//                                 ChangeLanguageEvent('en'),
//                               );
//                             },
//                             child: const SizedBox(
//                               width: 48,
//                               height: 48,
//                               child: Center(
//                                 child: Text(
//                                   '🇺🇸',
//                                   style: TextStyle(fontSize: 30),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         // Arabic flag
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedLanguage = 1;
//                               });
//
//                               context.read<LanguageBloc>().add(
//                                 ChangeLanguageEvent('ar'),
//                               );
//                             },
//                             child: const SizedBox(
//                               width: 48,
//                               height: 48,
//                               child: Center(
//                                 child: Text(
//                                   '🇪🇬',
//                                   style: TextStyle(fontSize: 30),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         // Yellow circle
//                         AnimatedAlign(
//                           duration: const Duration(milliseconds: 250),
//                           curve: Curves.easeInOut,
//                           alignment: selectedLanguage == 0
//                               ? Alignment.centerLeft
//                               : Alignment.centerRight,
//                           child: IgnorePointer(
//                             child: Container(
//                               width: 48,
//                               height: 48,
//                               decoration: const BoxDecoration(
//                                 color: AppColors.yellow,
//                                 shape: BoxShape.circle,
//                               ),
//                               alignment: Alignment.center,
//                               child: Text(
//                                 selectedLanguage == 0 ? '🇺🇸' : '🇪🇬',
//                                 style: const TextStyle(
//                                   fontSize: 30,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // void login()async{
//   //   if (formKey.currentState!.validate()==true) {
//   //     try {
//   //       //todo: 1-show loadding
//   //       DialogUtils.showLoading(context: context, loadingText: 'Loading....');
//   //       //todo :2- login FireBase Auth
//   //       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//   //         email: emailController.text,
//   //         password: passwordController.text,
//   //       );
//   //       //todo:3-read User from FireBase
//   //       var user = await FireBaseUtils.readUserFromFireStore(credential.user?.uid??'');
//   //       if (user == null){
//   //         return;
//   //       }
//   //       //todo :4- save user in provider
//   //       var userProviser=Provider.of<UserProvider>(context,listen: false);
//   //       userProviser.updateUser(user);
//   //
//   //
//   //       //todo:5- hide loading
//   //       DialogUtils.hideLoadong(context: context);
//   //
//   //       // todo: 6-show message
//   //       DialogUtils.showMessage(context: context,
//   //           message: 'Login Successfully.',
//   //           title: 'Success',posActionName: 'OK',posAction: (){
//   //             Navigator.of(context).pushNamed(AppRoutes.bottom_bar);
//   //           });
//   //
//   //
//   //     } on FirebaseAuthException catch (e) {
//   //
//   //       if (e.code == 'invalid-credential') {
//   //         //todo: hide loading
//   //         DialogUtils.hideLoadong(context: context);
//   //         // todo: show message>> error
//   //         DialogUtils.showMessage(context: context,
//   //             message: 'The Supplied auth Credential is in correct',
//   //             title: 'Error',posActionName: 'OK');
//   //       }
//   //     }catch(e){
//   //       //todo: hide loading
//   //       DialogUtils.hideLoadong(context: context);
//   //       // todo: show message>> error
//   //       DialogUtils.showMessage(context: context,
//   //           message: e.toString(),
//   //           title: 'Error',posActionName: 'OK');
//   //       print(e.toString());
//   //     }
//   //   }
//   // }
//   void login()async{
//     if (formKey.currentState!.validate()==true) {
//       try {
//         //todo: 1-show loadding
//         DialogUtils.showLoading(context: context, loadingText: 'Loading....');
//
//         //todo :2- login FireBase Auth
//         final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: emailController.text.trim(),
//           password: passwordController.text,
//         );
//
//         //todo:3-read User from FireBase
//         var user = await FireBaseUtils.readUserFromFireStore(
//           credential.user?.uid ?? '',
//         );
//
//         if (user == null){
//           DialogUtils.hideLoadong(context: context);
//
//           DialogUtils.showMessage(
//             context: context,
//             message: 'User data not found in Firestore.',
//             title: 'Error',
//             posActionName: 'OK',
//           );
//
//           return;
//         }
//
//         //todo :4- save user in provider
//         var userProviser=Provider.of<UserProvider>(
//           context,
//           listen: false,
//         );
//
//         userProviser.updateUser(user);
//
//         //todo:5- hide loading
//         DialogUtils.hideLoadong(context: context);
//
//         // todo: 6-show message
//         DialogUtils.showMessage(
//           context: context,
//           message: 'Login Successfully.',
//           title: 'Success',
//           posActionName: 'OK',
//           posAction: (){
//             Navigator.of(context).pushNamed(
//               AppRoutes.bottom_bar,
//             );
//           },
//         );
//
//       } on FirebaseAuthException catch (e) {
//
//         //todo: hide loading
//         DialogUtils.hideLoadong(context: context);
//
//         print('Firebase Auth Error Code: ${e.code}');
//         print('Firebase Auth Error Message: ${e.message}');
//
//         if (e.code == 'invalid-credential') {
//
//           // todo: show message>> error
//           DialogUtils.showMessage(
//             context: context,
//             message: 'The email or password is incorrect.',
//             title: 'Error',
//             posActionName: 'OK',
//           );
//
//         } else if (e.code == 'user-not-found') {
//
//           DialogUtils.showMessage(
//             context: context,
//             message: 'No account found with this email.',
//             title: 'Error',
//             posActionName: 'OK',
//           );
//
//         } else if (e.code == 'wrong-password') {
//
//           DialogUtils.showMessage(
//             context: context,
//             message: 'The password is incorrect.',
//             title: 'Error',
//             posActionName: 'OK',
//           );
//
//         } else if (e.code == 'invalid-email') {
//
//           DialogUtils.showMessage(
//             context: context,
//             message: 'The email address is invalid.',
//             title: 'Error',
//             posActionName: 'OK',
//           );
//
//         } else {
//
//           DialogUtils.showMessage(
//             context: context,
//             message: e.message ?? 'Something went wrong.',
//             title: 'Error',
//             posActionName: 'OK',
//           );
//         }
//
//       }catch(e){
//
//         //todo: hide loading
//         DialogUtils.hideLoadong(context: context);
//
//         // todo: show message>> error
//         DialogUtils.showMessage(
//           context: context,
//           message: e.toString(),
//           title: 'Error',
//           posActionName: 'OK',
//         );
//
//         print(e.toString());
//       }
//     }
//   }
//
//   Future<void> signInWithGoogle(BuildContext context) async {
//     try {
//       final GoogleSignIn googleSignIn = GoogleSignIn.instance;
//       await googleSignIn.initialize();
//
//       final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
//
//       final GoogleSignInAuthentication googleAuth = googleUser.authentication;
//
//       final credential = GoogleAuthProvider.credential(
//         idToken: googleAuth.idToken,
//       );
//
//       final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//
//       if (context.mounted) {
//         Navigator.of(context).pushReplacementNamed(AppRoutes.bottom_bar);
//       }
//     } on FirebaseAuthException catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Google sign-in failed: ${e.message}')),
//         );
//       }
//     } catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Something went wrong: $e')),
//         );
//       }
//     }
//   }
// }
//


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/core/utils/size_utils.dart';




import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/dialog_utils.dart';

import '../../../../presentation/bloc/auth/login/login_bloc.dart';
import '../../../../presentation/bloc/auth/login/login_event.dart';
import '../../../../presentation/bloc/auth/login/login_state.dart';
import '../../../../presentation/bloc/language/language_bloc.dart';
import '../../../../presentation/bloc/language/language_event.dart';
import '../../../../presentation/bloc/user/user_bloc.dart';
import '../../../../presentation/bloc/user/user_event.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../../presentation/widgets/custom_text_field.dart';
import '../../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedLanguage = 0;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;

    final localizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => LoginBloc(),

      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {

          // ================= LOADING =================

          if (state is LoginLoading) {
            DialogUtils.showLoading(
              context: context,
              loadingText: 'Loading....',
            );
          }

          // ================= SUCCESS =================

          if (state is LoginSuccess) {
            DialogUtils.hideLoadong(
              context: context,
            );

            // هنا بنجيب بيانات المستخدم من Firestore
            // ونحطها في UserBloc
            context.read<UserBloc>().add(
              LoadUserEvent(

                state.user.uid,
              ),
            );

            DialogUtils.showMessage(
              context: context,
              message: 'Login Successfully.',
              title: 'Success',
              posActionName: 'OK',
              posAction: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.bottom_bar,
                );
              },
            );
          }

          // ================= ERROR =================

          if (state is LoginError) {
            DialogUtils.hideLoadong(
              context: context,
            );

            DialogUtils.showMessage(
              context: context,
              message: state.message,
              title: 'Error',
              posActionName: 'OK',
            );
          }
        },

        // =========================================================
        // Builder
        // =========================================================

        child: Builder(
          builder: (context) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.black,

                body: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.02,
                  ),

                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: height * 0.02,

                        children: [

                          // ================= LOGO =================

                          Image.asset(
                            AppAssets.movieLogo,
                          ),

                          SizedBox(
                            height: height * 0.03,
                          ),

                          // ================= EMAIL =================

                          CustomTextField(
                            controller: emailController,

                            KeyboardType:
                            TextInputType.emailAddress,

                            validator: (text) {
                              if (text == null ||
                                  text.trim().isEmpty) {
                                return 'Please Enter an email';
                              }

                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(text.trim())) {
                                return 'Please enter a valid email address';
                              }

                              return null;
                            },

                            borderColor:
                            AppColors.transparentColor,

                            filled: true,

                            fillColor:
                            AppColors.darkGray,

                            hintText:
                            localizations.email,

                            hintStyle:
                            AppStyles.regular16White,

                            prefixIcon: Icon(
                              Icons.email_rounded,
                              color: AppColors.white,
                            ),
                          ),

                          // ================= PASSWORD =================

                          CustomTextField(
                            controller: passwordController,

                            obscureText: true,

                            validator: (password) {
                              if (password == null ||
                                  password.trim().isEmpty) {
                                return 'Please Enter a Password';
                              }

                              if (password.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }

                              return null;
                            },

                            borderColor:
                            AppColors.transparentColor,

                            filled: true,

                            fillColor:
                            AppColors.darkGray,

                            hintText:
                            localizations.password,

                            hintStyle:
                            AppStyles.regular16White,

                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.white,
                            ),

                            suffixIcon: Icon(
                              Icons.visibility_off_rounded,
                              color: AppColors.white,
                            ),
                          ),

                          // ================= FORGET PASSWORD =================

                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.reset_password,
                              );
                            },

                            child: Align(
                              alignment:
                              AlignmentDirectional.centerEnd,

                              child: Text(
                                localizations.forget_password,
                                style:
                                AppStyles.regular14Yellow,
                              ),
                            ),
                          ),

                          // ================= LOGIN BUTTON =================

                          SizedBox(
                            width: double.infinity,

                            child: CustomElevatedButton(
                              onPressed: () {

                                if (formKey.currentState!
                                    .validate()) {

                                  context
                                      .read<LoginBloc>()
                                      .add(
                                    LoginSubmitted(
                                      email: emailController
                                          .text
                                          .trim(),

                                      password:
                                      passwordController.text,
                                    ),
                                  );
                                }
                              },

                              verticalPadding:
                              height * 0.01,

                              backgroundColor:
                              AppColors.yellow,

                              child: Text(
                                localizations.login,
                                style:
                                AppStyles.regular20DarkGray,
                              ),
                            ),
                          ),

                          // ================= CREATE ACCOUNT =================

                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,

                            children: [

                              Text(
                                localizations
                                    .dont_have_an_account,

                                style:
                                AppStyles.regular14White,
                              ),

                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(
                                    AppRoutes.register_screen,
                                  );
                                },

                                child: Align(
                                  alignment:
                                  AlignmentDirectional.center,

                                  child: Text(
                                    localizations.create_one,

                                    style:
                                    AppStyles.black14Yellow,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // ================= OR =================

                          Row(
                            children: [

                              Expanded(
                                child: Divider(
                                  thickness: 2,
                                  color: AppColors.yellow,
                                  indent: width * 0.01,
                                  endIndent: width * 0.04,
                                ),
                              ),

                              Text(
                                localizations.or,
                                style:
                                AppStyles.regular15Yellow,
                              ),

                              Expanded(
                                child: Divider(
                                  thickness: 2,
                                  color: AppColors.yellow,
                                  indent: width * 0.01,
                                  endIndent: width * 0.04,
                                ),
                              ),
                            ],
                          ),

                          // ================= GOOGLE LOGIN =================

                          SizedBox(
                            width: double.infinity,

                            child: CustomElevatedButton(
                              onPressed: () {
                                signInWithGoogle(context);
                              },

                              verticalPadding:
                              height * 0.02,

                              backgroundColor:
                              AppColors.yellow,

                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,

                                spacing: width * 0.04,

                                children: [

                                  Image.asset(
                                    AppAssets.googleLogo,
                                  ),

                                  Text(
                                    localizations
                                        .login_with_google,

                                    style:
                                    AppStyles.regular16DarkGray,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // ================= LANGUAGE SWITCHER =================

                          Container(
                            width: 130,
                            height: 62,

                            padding:
                            const EdgeInsets.all(5),

                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.yellow,
                                width: 3,
                              ),

                              borderRadius:
                              BorderRadius.circular(35),
                            ),

                            child: Stack(
                              children: [

                                // ================= ENGLISH =================

                                Align(
                                  alignment:
                                  Alignment.centerLeft,

                                  child: GestureDetector(
                                    onTap: () {

                                      setState(() {
                                        selectedLanguage = 0;
                                      });

                                      context
                                          .read<LanguageBloc>()
                                          .add(
                                        ChangeLanguageEvent(
                                          'en',
                                        ),
                                      );
                                    },

                                    child: const SizedBox(
                                      width: 48,
                                      height: 48,

                                      child: Center(
                                        child: Text(
                                          '🇺🇸',
                                          style:
                                          TextStyle(
                                            fontSize: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // ================= ARABIC =================

                                Align(
                                  alignment:
                                  Alignment.centerRight,

                                  child: GestureDetector(
                                    onTap: () {

                                      setState(() {
                                        selectedLanguage = 1;
                                      });

                                      context
                                          .read<LanguageBloc>()
                                          .add(
                                        ChangeLanguageEvent(
                                          'ar',
                                        ),
                                      );
                                    },

                                    child: const SizedBox(
                                      width: 48,
                                      height: 48,

                                      child: Center(
                                        child: Text(
                                          '🇪🇬',
                                          style:
                                          TextStyle(
                                            fontSize: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // ================= SELECTED LANGUAGE =================

                                AnimatedAlign(
                                  duration:
                                  const Duration(
                                    milliseconds: 250,
                                  ),

                                  curve:
                                  Curves.easeInOut,

                                  alignment:
                                  selectedLanguage == 0
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,

                                  child: IgnorePointer(
                                    child: Container(
                                      width: 48,
                                      height: 48,

                                      decoration:
                                      const BoxDecoration(
                                        color:
                                        AppColors.yellow,
                                        shape:
                                        BoxShape.circle,
                                      ),

                                      alignment:
                                      Alignment.center,

                                      child: Text(
                                        selectedLanguage == 0
                                            ? '🇺🇸'
                                            : '🇪🇬',

                                        style:
                                        const TextStyle(
                                          fontSize: 30,
                                        ),
                                      ),
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // =========================================================
  // GOOGLE SIGN IN
  // =========================================================

  Future<void> signInWithGoogle(
      BuildContext context,
      ) async {
    try {

      final GoogleSignIn googleSignIn =
          GoogleSignIn.instance;

      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser =
      await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final credential =
      GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      // ================= GET FIREBASE USER =================

      final User? user = userCredential.user;

      if (user == null) {
        throw Exception('Google user not found');
      }

      // ================= LOAD USER DATA =================

      context.read<UserBloc>().add(
        LoadUserEvent(
          user.uid,
        ),
      );

      // ================= NAVIGATE =================

      if (!context.mounted) return;

      Navigator.of(context).pushReplacementNamed(
        AppRoutes.bottom_bar,
      );

    } on FirebaseAuthException catch (e) {

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Google sign-in failed: ${e.message}',
            ),
          ),
        );
      }

    } catch (e) {

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Something went wrong: $e',
            ),
          ),
        );
      }
    }
  }
}
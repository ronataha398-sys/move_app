
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:movie_app/presentation/bloc/language/language_bloc.dart';
import 'package:movie_app/presentation/bloc/language/language_state.dart';
import 'package:movie_app/presentation/bloc/profile/proflie_bloc.dart';
import 'package:movie_app/presentation/bloc/user/user_bloc.dart';

import 'package:movie_app/presentation/screens/Auth/login/login_screen.dart';
import 'package:movie_app/presentation/screens/Auth/register/register_screen.dart';
import 'package:movie_app/presentation/screens/Auth/reset_password/reset_password.dart';

import 'package:movie_app/presentation/screens/home/tabs/home_screen.dart';
import 'package:movie_app/presentation/screens/home/tabs/profile_tab.dart';
import 'package:movie_app/presentation/screens/home/tabs/update_profile/update_profile.dart';
import 'package:movie_app/presentation/screens/home/widgets/bottom_bar.dart';

import 'package:movie_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:movie_app/presentation/screens/splash/splash_screens.dart';

import 'firebase_options.dart';
import 'core/routes/app_routes.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    debugPrint("🔥 Firebase initialized successfully");
  } catch (e) {
    debugPrint("🔥 Firebase ERROR: $e");
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: Locale(state.languageCode),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,

          home: const SplashScreen(),

          routes: {
            AppRoutes.onboarding: (context) =>
            const OnboardingScreen(),

            AppRoutes.login_screen: (context) =>
                LoginScreen(),

            AppRoutes.home: (context) =>
                HomeScreen(),

            AppRoutes.register_screen: (context) =>
                RegisterScreen(),

            AppRoutes.reset_password: (context) =>
            const ResetPassword(),

            AppRoutes.bottom_bar: (context) =>
                BottomBar(),

            AppRoutes.update_profile: (context) =>
            const UpdateProfile(),

            AppRoutes.profile_tab: (context) =>
            const ProfileTab(),
          },
        );
      },
    );
  }
}

import '../../../core/utils/app_assets.dart';

class OnboardingData {
  final String backgroundImage;
  final String? overlayImage;
  final String title;
  final String description;
  final String buttonText;

  const OnboardingData({
    required this.backgroundImage,
    this.overlayImage,
    required this.title,
    required this.description,
    this.buttonText = "Next",
  });
}

const List<OnboardingData> onboardingPages = [
  OnboardingData(
    backgroundImage: AppAssets.mainOnboarding,
    overlayImage: AppAssets.mainOverLayer,
    title: "Find Your Next\nFavorite Movie Here",
    description:
    "Get access to a huge library of movies to suit all tastes. You will surely like it.",
    buttonText: "Explore Now",
  ),

  OnboardingData(
    backgroundImage: AppAssets.onBoarding_1,
    overlayImage: AppAssets.overLayer1,
    title: "Discover Movies",
    description:
    "Explore a vast collection of movies in all\nqualities and genres. Find your next\nfavorite film with ease.",
  ),

  OnboardingData(
    backgroundImage: AppAssets.onBoarding_2,
    overlayImage: AppAssets.overLayer2,
    title: "Explore All Genres",
    description:
    "Discover movies from every genre in all\n available qualities. Find something new\nand exciting to watch every day.",
  ),

  OnboardingData(
    backgroundImage: AppAssets.onBoarding_3,
    overlayImage: AppAssets.overLayer3,
    title: "Create Watchlists",
    description:
    "Save movies to your watchlist to keep\ntrack of what you want to watch next.\nEnjoy films in various qualities\nand genres.",
  ),

  OnboardingData(
    backgroundImage: AppAssets.onBoarding_4,
    overlayImage: AppAssets.overLayer4,
    title: "Rate, Review, and Learn",
    description:
    "Share your thoughts on the movies\nyou've watched. Dive deep into film\ndetails and help others discover great\nmovies with your reviews.",
  ),

  OnboardingData(
    backgroundImage: AppAssets.onBoarding_5,
    overlayImage: AppAssets.overLayer5,
    title: "Start Watching Now",
    description: "",
    buttonText: "Get Started",
  ),
];
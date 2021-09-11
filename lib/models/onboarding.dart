class OnBoarding {
  final String title;
  final String image;

  OnBoarding({
    required this.title,
    required this.image,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
    title: 'Welcome to\n Laundro picker',
    image: 'assets/images/slide_one.png',
    // image: 'https://raw.githubusercontent.com/tonydavidx/habit-app-flutter/project_start/assets/images/onboarding_image_1.png',
  ),
  OnBoarding(
    title: 'Create new laundromats easily',
    image: 'assets/images/slide_three.png',
    // image: 'https://raw.githubusercontent.com/tonydavidx/habit-app-flutter/project_start/assets/images/onboarding_image_2.png',
  ),
  OnBoarding(
    title: 'Keep track of your business',
    image: 'assets/images/slide_four.png',
    // image: 'https://raw.githubusercontent.com/tonydavidx/habit-app-flutter/project_start/assets/images/onboarding_image_3.png',
  ),
  OnBoarding(
    title: 'Create a supportive community',
    image: 'assets/images/slide_five.png',
    // image:'https://raw.githubusercontent.com/tonydavidx/habit-app-flutter/project_start/assets/images/onboarding_image_4.png',
  ),
];

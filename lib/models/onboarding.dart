class OnBoarding {
  final String title;
  final String description;
  final String image;

  OnBoarding({
    required this.title,
    required this.image,
    required this.description,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
      title: 'Welcome to\n Laundro picker',
      image: 'assets/images/slide_one.png',
      description: 'Choose items from our price list'
      // image: 'https://raw.githubusercontent.com/tonydavidx/habit-app-flutter/project_start/assets/images/onboarding_image_1.png',
      ),
  OnBoarding(
      title: 'Create new laundromats easily',
      image: 'assets/images/slide_two.png',
      description: 'Skip ahead with "Instant Order" and we fill up'
      // image: 'https://raw.githubusercontent.com/tonydavidx/habit-app-flutter/project_start/assets/images/onboarding_image_2.png',
      ),
  OnBoarding(
      title: 'Keep track of your business',
      image: 'assets/images/slide_three.png',
      description: 'Schedule Instant Order delivery'
      // image: 'https://raw.githubusercontent.com/tonydavidx/habit-app-flutter/project_start/assets/images/onboarding_image_3.png',
      ),
];

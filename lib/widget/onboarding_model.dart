class OnBoardingData {
  String title;
  String descrebtion;
  String image;
  OnBoardingData({
    required this.title,
    required this.image,
    required this.descrebtion,
  });
}

List<OnBoardingData> dataOnBoarding() {
  return [
    OnBoardingData(
      title: 'Manage your tasks',
      image: 'assets/images/on_boarding1.png',
      descrebtion:
          'You can easily manage all of your daily tasks in DoMe for free',
    ),
    OnBoardingData(
      title: 'Create daily routine',
      image: 'assets/images/on_boarding2.png',
      descrebtion:
          'In Tasky  you can create your personalized routine to stay productive',
    ),
    OnBoardingData(
      title: 'Orgonaize your tasks',
      image: 'assets/images/on_boarding3.png',
      descrebtion:
          'You can organize your daily tasks by adding your tasks into separate categories',
    ),
  ];
}

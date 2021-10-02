import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/onboarding.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../widgets/Buttons/my_text_button.dart';
import '../widgets/Buttons/onboard_nav_btn.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
        margin: const EdgeInsets.only(right: 5),
        duration: const Duration(milliseconds: 400),
        height: 12,
        width: 12,
        curve: Curves.elasticIn,
        decoration: BoxDecoration(
            color: currentPage == index
                ? Constants.primaryColor
                : Constants.secondaryColor,
            borderRadius: BorderRadius.circular(10.0)));
  }

  Future setSeenonboard() async {
    final prefs = await SharedPreferences.getInstance();
    // Set seenOnboard to true
    await prefs.setBool('seenOnboard', true);
  }

  @override
  void initState() {
    super.initState();
    setSeenonboard();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final sizeV = SizeConfig.blockSizeVertical;
    return Scaffold(
        backgroundColor: Constants.white,
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                flex: 9,
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: onboardingContents.length,
                    itemBuilder: (context, index) => Column(children: [
                          SizedBox(height: sizeV * 5),
                          SizedBox(
                              height: sizeV * 50,
                              // child: Image.network(onboardingContents[index].image,
                              //     fit: BoxFit.fill)),
                              child: Image.asset(
                                  onboardingContents[index].image,
                                  fit: BoxFit.fill)),
                          SizedBox(height: sizeV * 5),
                          Text(onboardingContents[index].title,
                              style: Constants.kTitle,
                              textAlign: TextAlign.center),
                          SizedBox(height: sizeV * 5),
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: Constants.kBodyText1,
                                  children: [
                                    //or skip ahead with "Instant Order" and we fill up
                                    TextSpan(
                                        text: onboardingContents[index]
                                            .description,
                                        style: TextStyle(
                                            color: Constants.primaryColor))
                                  ])),
                          SizedBox(height: sizeV * 5),
                        ]))),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    currentPage == onboardingContents.length - 1
                        ? MyTextButton(
                            buttonName: 'Get Started',
                            textStyle: TextStyle(
                                color: Constants.white,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                                fontWeight: FontWeight.bold),
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/category'),
                            bgColor: Constants.primaryColor)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                                OnBoardNavBtn(
                                    name: 'Skip',
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed('/category')),
                                Row(
                                    children: List.generate(
                                        onboardingContents.length,
                                        (index) => dotIndicator(index))),
                                OnBoardNavBtn(
                                    name: 'Next',
                                    onPressed: () {
                                      _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.elasticInOut,
                                      );
                                    })
                              ]),
                  ],
                ))
          ],
        )));
  }
}

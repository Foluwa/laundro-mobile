import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/slider.dart';
import '../utils/constants.dart';
import 'slide_dots.dart';
import 'slide_item.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int index) {
    if (mounted) {
      setState(() {
        _currentPage = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) => topSliderLayout();

  Widget topSliderLayout() => Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    onPageChanged: onPageChanged,
                    itemCount: sliderArrayList.length,
                    itemBuilder: (ctx, i) => SlideItem(i)),
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: <Widget>[
                    const InkWell(
                      // onTap: () => Navigator.of(context).pushNamed('/home'),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                          child: Text(
                            Constants.NEXT,
                            style: TextStyle(
                              fontFamily: Constants.OPEN_SANS,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pushNamed('/home'),
                      child: const Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
                          child: Text(
                            Constants.SKIP,
                            style: TextStyle(
                              fontFamily: Constants.OPEN_SANS,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0; i < sliderArrayList.length; i++)
                            if (i == _currentPage)
                              SlideDots(true)
                            else
                              SlideDots(false)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )),
      );
}

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:introduction_screen/introduction_screen.dart';
//
// class OnBoardingPage extends StatefulWidget {
//   const OnBoardingPage({Key? key}) : super(key: key);
//   @override
//   _OnBoardingPageState createState() => _OnBoardingPageState();
// }
//
// class _OnBoardingPageState extends State<OnBoardingPage> {
//   final introKey = GlobalKey<IntroductionScreenState>();
//
//   void _onIntroEnd(context) {
//     Navigator.of(context).pushNamed('/categories');
//   }
//
//   Widget _buildImage(String assetName, [double width = 350]) {
//     return Image.asset('assets/$assetName', width: width);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const bodyStyle = TextStyle(fontSize: 19.0);
//
//     const pageDecoration = PageDecoration(
//       titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
//       bodyTextStyle: bodyStyle,
//       descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//       pageColor: Colors.white,
//       imagePadding: EdgeInsets.zero,
//     );
//
//     return IntroductionScreen(
//       key: introKey,
//       globalBackgroundColor: Colors.white,
//       pages: [
//         PageViewModel(
//           title: 'Lorem Ipsum ',
//           body: 'Lorem ipsum dolor sit amet consectetur adipisicing elit',
//           // image: _buildImage('img1.jpg'),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: 'Lorem Ipsum ',
//           bodyWidget: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Text('Lorem ipsum ', style: bodyStyle),
//               Text('dolor sit amet ', style: bodyStyle),
//             ],
//           ),
//           decoration: pageDecoration,
//           image: _buildImage('img2.jpg'),
//         ),
//       ],
//       onDone: () => _onIntroEnd(context),
//       //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
//       showSkipButton: true,
//       skipFlex: 0,
//       nextFlex: 0,
//       skip: const Text('Skip'),
//       next: const Icon(Icons.arrow_forward),
//       done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
//       curve: Curves.fastLinearToSlowEaseIn,
//       controlsMargin: const EdgeInsets.all(16),
//       controlsPadding: kIsWeb
//           ? const EdgeInsets.all(12.0)
//           : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
//       dotsDecorator: const DotsDecorator(
//         size: Size(10.0, 10.0),
//         color: Color(0xFFBDBDBD),
//         activeSize: Size(22.0, 10.0),
//         activeShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(25.0)),
//         ),
//       ),
//       dotsContainerDecorator: const ShapeDecoration(
//         //color: Colors.black87,
//         color: Colors.transparent,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8.0)),
//         ),
//       ),
//     );
//   }
// }

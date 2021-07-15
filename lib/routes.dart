import 'package:flutter/material.dart';
import 'package:laundro/screens/user/category.dart';
import 'package:page_transition/page_transition.dart';

import 'screens/user/category_screen.dart';
import 'screens/user/launch_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting args for navigator.pushNamed
    final args = settings.arguments;
    print('Route information: ' + settings.name);
    switch (settings.name) {
      case '/':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: const LaunchScreen());
      case '/categories':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: CategoryList());
      case '/category_details':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: CategoryScreen());
      // case '/category_detail':
      //   return PageTransition(
      //       type: PageTransitionType.bottomToTop, child: ArticleDetail());
      // case '/walkthrough':
      //   return MaterialPageRoute(builder: (_) => WalkThroughPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error Page'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}

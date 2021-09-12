import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'screens/onboarding.dart';
import 'screens/account.dart';
import 'screens/cart.dart';
import 'screens/category.dart';
import 'screens/category_screen.dart';
import 'screens/checkout.dart';
import 'screens/order_history.dart';
import 'screens/search.dart';
import 'screens/signin.dart';
import 'screens/signup.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting args for navigator.pushNamed
    final args = settings.arguments;
    print('Route information: ' + settings.name!);

    switch (settings.name) {
      case '/':
        return PageTransition(
            type: PageTransitionType.bottomToTop,
            child: const OnBoardingPage()); //Onboarding
      case '/home':
        return PageTransition(
            type: PageTransitionType.bottomToTop,
            child: const CategoryWidgetList()); // CategoryWidgetList
      case '/category_details':
        return PageTransition(
            type: PageTransitionType.bottomToTop,
            child: CategoryScreen(subCat: args));
      case '/order_history':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: const OrderHistory());
      case '/account':
        return PageTransition(
            type: PageTransitionType.topToBottom, child: const Account());
      case '/search':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: const SearchScreen());
      case '/cart':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: const Cart());
      case '/checkout':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: const Checkout());
      case '/signup':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: const SignUp());
      case '/signin':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: const SignIn());
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

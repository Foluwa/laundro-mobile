import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundro/screens/forgot_password.dart';
import 'package:page_transition/page_transition.dart';

import 'screens/account_page.dart';
import 'screens/cart.dart';
import 'screens/category_list.dart';
import 'screens/category_sub.dart';
import 'screens/checkout.dart';
import 'screens/menu_page.dart';
import 'screens/onboarding.dart';
import 'screens/orders_details.dart';
import 'screens/orders_list.dart';
import 'screens/search.dart';
import 'screens/signin.dart';
import 'screens/signup.dart';
import 'utils/constants.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    print('Route information: ' + settings.name!);
    switch (settings.name) {
      case '/':
        return PageTransition(
            type: PageTransitionType.bottomToTop,
            child: const OnBoardingPage());
      case '/category':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: const CategoryList());
      case '/subcategory':
        return PageTransition(
            type: PageTransitionType.bottomToTop,
            child: SubCategory(subCat: args));
      case '/order_history':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: const OrdersList());
      case '/single_order':
        return PageTransition(
            type: PageTransitionType.bottomToTop,
            child: OrdersDetails(order: args));
      case '/account':
        return PageTransition(
            type: PageTransitionType.topToBottom, child: const AccountsPage());
      case '/menu':
        return PageTransition(
            type: PageTransitionType.topToBottom, child: const MenuPage());
      case '/search':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: const SearchScreen());
      case '/cart':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: const Cart());
      case '/checkout':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: const Checkout());
      case '/payment_success':
        return paymentSuccess();
      case '/signup':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: const SignUp());
      case '/signin':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: const SignIn());
      case '/forgot_password':
        return PageTransition(
            // ignore: lines_longer_than_80_chars
            type: PageTransitionType.bottomToTop,
            child: const ForgotPassword());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          backgroundColor: Constants.primaryColor,
          appBar: AppBar(title: const Text('Error Page')),
          body: const Center(child: Text('Error')));
    });
  }

  static Route<dynamic> paymentSuccess() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          backgroundColor: Constants.primaryColor,
          appBar: AppBar(title: const Text('Payment Success Page')),
          body: const Center(child: Text('Payment Success Page')));
    });
  }
}

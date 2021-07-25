import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundro/screens/user/cart.dart';
import 'package:page_transition/page_transition.dart';

import 'screens/user/account.dart';
import 'screens/user/category.dart';
import 'screens/user/category_screen.dart';
import 'screens/user/order_history.dart';
import 'screens/user/search.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting args for navigator.pushNamed
    final args = settings.arguments;
    print('Route information: ' + settings.name!);
    switch (settings.name) {
      // case '/':
      //   return PageTransition(
      //       type: PageTransitionType.topToBottom, child: const LaunchScreen());
      // categories
      case '/':
        return PageTransition(
            type: PageTransitionType.bottomToTop,
            child: const CategoryWidgetList());
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
            type: PageTransitionType.bottomToTop,
            child: const GridSearchScreen());
      case '/cart':
        return PageTransition(
            type: PageTransitionType.bottomToTop, child: const Cart());
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

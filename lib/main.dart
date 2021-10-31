import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/l10n.dart';
import 'models/cart.dart';
import 'providers/laundry_provider.dart';
import 'providers/locale_provider.dart';
import 'providers/order_provider.dart';
import 'providers/payment_provider.dart';
import 'providers/user_provider.dart';
import 'routes.dart';
import 'utils/constants.dart';

String? initialRoute;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init hive db
  await Hive.initFlutter();
  Hive.registerAdapter(CartDBAdapter());
  await Hive.openBox<CartDB>('cart');

  // Onboarding
  final prefs = await SharedPreferences.getInstance();
  final seenOnboarding = prefs.getBool('seenOnboard') ?? false;
  (seenOnboarding) ? initialRoute = '/category' : initialRoute = '/';

  /// Disable screen rotation
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((val) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PaymentProvider()),
          ChangeNotifierProvider(create: (context) => OrderProvider()),
          ChangeNotifierProvider(create: (context) => LaundryProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ],
        child: Consumer<LocaleProvider>(builder: (context, provider, snapshot) {
          return MaterialApp(
              title: Constants.appName,
              theme: ThemeData(
                  textTheme: GoogleFonts.montserratTextTheme(
                      Theme.of(context).textTheme)),
              debugShowCheckedModeBanner: Constants.showDebugBanner,
              locale: provider.locale,
              supportedLocales: L10n.all,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              initialRoute: initialRoute ?? '/',
              onGenerateRoute: RouteGenerator.generateRoute);
        }));
  }
}

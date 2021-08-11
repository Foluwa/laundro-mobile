import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:laundro/utils/db/persist_basket.dart';
import 'package:provider/provider.dart';
import 'l10n/l10n.dart';
import 'providers/laundry_provider.dart';
import 'providers/locale_provider.dart';
import 'providers/user_provider.dart';
import 'routes.dart';
import 'utils/constants.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// Initialize sq-lite
  // final db = SqliteDB();
  // await db.countTable();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LaundryProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ],
        child: Consumer<LocaleProvider>(builder: (context, provider, snapshot) {
          return MaterialApp(
              title: Constants.appName,
              theme: ThemeData(
                  primarySwatch: Colors.blue,
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
              initialRoute: '/',
              onGenerateRoute: RouteGenerator.generateRoute);
        }));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/l10n.dart';
import 'providers/laundry_provider.dart';
import 'providers/locale_provider.dart';
import 'routes.dart';
import 'utils/constants.dart';

// void main() => runApp(MyApp());
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LaundryProvider(),
        ),
      ],
      child: Consumer<LocaleProvider>(builder: (_, locale, child) {
        return MaterialApp(
          title: Constants.appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: Constants.showDebugBanner,
          locale: locale.locale,
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      }),
    );
  }
}

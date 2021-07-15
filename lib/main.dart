import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:laundro/providers/locale_provider.dart';
import 'package:provider/provider.dart';

import 'l10n/l10n.dart';
import 'routes.dart';

// void main() => runApp(MyApp());
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
        ),
      ],
      child: Consumer<LocaleProvider>(builder: (_, locale, child) {
        return MaterialApp(
          title: 'laundro',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
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

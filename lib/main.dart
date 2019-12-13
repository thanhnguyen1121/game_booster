import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'gameBoosterScreen/selectScreen/SelectScreenComponent.dart';
import 'locales/i18n.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  String showIntro;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        Locale('en'),
        Locale('vi'),
      ],
      localizationsDelegates: [
        I18n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (locale != null && supportedLocale != null) {
            print(supportedLocale);
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return supportedLocales.first;
      },
      title: 'PUPG Trick ',
      theme: new ThemeData(
          primarySwatch: Colors.blue,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          })),
      routes: {
        '/': (context) => SelectScreenComponent(),
//        '/': (context) => AddAppBoosterComponent(),
//        '/': (context) => TabPubgSelectComponent("PUBG"),
      },
    );
  }
}

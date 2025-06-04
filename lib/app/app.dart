import 'package:beauty_car/app/sharedPrefs/app_prefs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../splash/splash_screen.dart';
import 'di/di.dart';

class MyApp extends StatefulWidget {
  //named constructor
  MyApp._internal();

  static final MyApp _instance =
      MyApp._internal(); //singleton or single instance

  factory MyApp() => _instance; //factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocale().then((locale) => context.setLocale(locale));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

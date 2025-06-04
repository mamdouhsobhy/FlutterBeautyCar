import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app/sharedPrefs/app_prefs.dart';
import '../app/di/di.dart';
import '../onboarding/view/onboarding_screen.dart';
import '../resources/assetsManager.dart';
import '../resources/colorManager.dart';
import '../resources/constantsManager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), () {
      _goNext();
    });
  }

  Future<void> _goNext() async {
    bool isUserLoggedIn = await _appPreferences.isUserLoggedIn();
    print("Routs $isUserLoggedIn");
    if (isUserLoggedIn) {
      // initAttendenceModule();
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreen()),
      // );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }


  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: ColorManager.colorGray_5A,
        statusBarIconBrightness: Brightness.dark,
      ),
    child: Scaffold(
      backgroundColor: ColorManager.colorGray_5A,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(fit: BoxFit.fill,ImageAssets.splashLogo),
        ),
      ),
    )
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

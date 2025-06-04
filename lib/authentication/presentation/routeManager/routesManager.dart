import 'package:beauty_car/authentication/presentation/forgetPasswordScreen/forget_password_screen.dart';
import 'package:beauty_car/authentication/presentation/registerScreen/register_screen.dart';
import 'package:beauty_car/authentication/presentation/verifyCodeScreen/verify_code_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../app/di/di.dart';
import '../loginScreen/view/login_screen.dart';
import '../resetPasswordScreen/reset_password_screen.dart';

class Routes {
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String verifyCodeRoute = "/verifyCode";
  static const String resetPasswordRoute = "/resetPassword";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        //initLoginModule();
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
          settings: settings,
        );
      case Routes.forgetPasswordRoute:
        //initLoginModule();
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordScreen(),
          settings: settings,
        );
      case Routes.verifyCodeRoute:
        //nitLoginModule();
        return MaterialPageRoute(
          builder: (_) => const VerifyCodeScreen(),
          settings: settings,
        );
      case Routes.resetPasswordRoute:
        //initLoginModule();
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
          settings: settings,
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text("AppStrings.noRouteFound"),
          ),
          body: Center(child: Text("AppStrings.noRouteFound")),
        ));
  }
}
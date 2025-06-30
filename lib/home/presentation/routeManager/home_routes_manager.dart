import 'package:beauty_car/home/presentation/changePasswordScreen/change_password_screen.dart';
import 'package:beauty_car/home/presentation/createEmployeeScreen/view/create_employee_screen.dart';
import 'package:beauty_car/home/presentation/editProfileScreen/edit_profile_screen.dart';
import 'package:beauty_car/home/presentation/moreOrdersPageScreen/view/more_orders_page_screen.dart';
import 'package:beauty_car/home/presentation/settingPageScreen/setting_page_screen.dart';
import 'package:flutter/material.dart';
import '../../../app/di/di.dart';
import '../createCenterScreen/view/create_center_screen.dart';
import '../employeeDetailsPageScreen/view/employee_details_page_screen.dart';
import '../reserveDetailsPageScreen/view/reserve_details_page_screen.dart';

class HomeRoutes {
  static const String createCenterRoute = "/createCenter";
  static const String reserveDetailsRoute = "/reserveDetails";
  static const String employeeDetailsRoute = "/employeeDetails";
  static const String moreOrdersRoute = "/moreOrders";
  static const String createEmployeeRoute = "/createEmployee";
  static const String settingsRoute = "/setting";
  static const String editProfileRoute = "/editProfile";
  static const String changePasswordRoute = "/changePassword";
}

class HomeRouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeRoutes.createCenterRoute:
        initCreateCentersModule();
        return MaterialPageRoute(
            builder: (_) => const CreateCenterScreen(),
            settings: settings);
      case HomeRoutes.reserveDetailsRoute:
        initOrderDetailsModule();
        return MaterialPageRoute(
            builder: (_) => const ReserveDetailsPageScreen(),
            settings: settings);
      case HomeRoutes.employeeDetailsRoute:
        initEmployeeDetailsModule();
        initEmployeeReviewModule();
        initEmployeeAppointmentOrderModule();
        return MaterialPageRoute(
            builder: (_) => const EmployeeDetailsPageScreen(),
            settings: settings);
      case HomeRoutes.moreOrdersRoute:
        return MaterialPageRoute(
            builder: (_) => const MoreOrdersPageScreen());
      case HomeRoutes.createEmployeeRoute:
        initCreateEmployeeModule();
        return MaterialPageRoute(
            builder: (_) => const CreateEmployeeScreen(),
            settings: settings);
      case HomeRoutes.settingsRoute:
        return MaterialPageRoute(
            builder: (_) => const SettingPageScreen(),
            settings: settings);
      case HomeRoutes.editProfileRoute:
        initEditProfileModule();
        return MaterialPageRoute(
            builder: (_) => const EditProfileScreen(),
            settings: settings);
      case HomeRoutes.changePasswordRoute:
        return MaterialPageRoute(
            builder: (_) => const ChangePasswordScreen(),
            settings: settings);
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("AppStrings.noRouteFound"),
              ),
              body: const Center(child: Text("AppStrings.noRouteFound")),
            ));
  }
}

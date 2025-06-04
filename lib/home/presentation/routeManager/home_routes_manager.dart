import 'package:flutter/material.dart';
import '../createCenterScreen/create_center_screen.dart';
import '../employeeDetailsPageScreen/employee_details_page_screen.dart';
import '../reserveDetailsPageScreen/reserve_details_page_screen.dart';

class HomeRoutes {
  static const String createCenterRoute = "/createCenter";
  static const String reserveDetailsRoute = "/reserveDetails";
  static const String employeeDetailsRoute = "/employeeDetails";
}

class HomeRouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeRoutes.createCenterRoute:
        return MaterialPageRoute(
            builder: (_) => const CreateCenterScreen());
      case HomeRoutes.reserveDetailsRoute:
        return MaterialPageRoute(
            builder: (_) => const ReserveDetailsPageScreen());
      case HomeRoutes.employeeDetailsRoute:
        return MaterialPageRoute(
            builder: (_) => const EmployeeDetailsPageScreen());
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

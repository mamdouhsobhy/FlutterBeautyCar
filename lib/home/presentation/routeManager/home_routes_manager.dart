import 'package:beauty_car/home/presentation/moreOrdersPageScreen/view/more_orders_page_screen.dart';
import 'package:flutter/material.dart';
import '../../../app/di/di.dart';
import '../createCenterScreen/view/create_center_screen.dart';
import '../employeeDetailsPageScreen/employee_details_page_screen.dart';
import '../reserveDetailsPageScreen/reserve_details_page_screen.dart';

class HomeRoutes {
  static const String createCenterRoute = "/createCenter";
  static const String reserveDetailsRoute = "/reserveDetails";
  static const String employeeDetailsRoute = "/employeeDetails";
  static const String moreOrdersRoute = "/moreOrders";
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
        return MaterialPageRoute(
            builder: (_) => const ReserveDetailsPageScreen());
      case HomeRoutes.employeeDetailsRoute:
        return MaterialPageRoute(
            builder: (_) => const EmployeeDetailsPageScreen());
      case HomeRoutes.moreOrdersRoute:
        return MaterialPageRoute(
            builder: (_) => const MoreOrdersPageScreen());
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

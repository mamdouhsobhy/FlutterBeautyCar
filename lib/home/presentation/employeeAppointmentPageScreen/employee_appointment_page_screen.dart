import 'package:flutter/material.dart';

import '../../../resources/valuesManager.dart';
import '../homeSharedViews/employee_appointment_item_card.dart';
import '../homeSharedViews/employee_item_card.dart';
import '../routeManager/home_routes_manager.dart';

class EmployeeAppointmentPageScreen extends StatefulWidget {
  const EmployeeAppointmentPageScreen({super.key});

  @override
  State<EmployeeAppointmentPageScreen> createState() => _EmployeeAppointmentPageScreenState();
}

class _EmployeeAppointmentPageScreenState extends State<EmployeeAppointmentPageScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p8, horizontal: AppPadding.p16),
          child: EmployeeAppointmentItemCard(),
        );
      },
    );
  }
}

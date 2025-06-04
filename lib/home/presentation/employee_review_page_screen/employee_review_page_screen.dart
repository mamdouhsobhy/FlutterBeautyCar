import 'package:flutter/material.dart';

import '../../../resources/valuesManager.dart';
import '../homeSharedViews/employee_review_item_card.dart';

class EmployeeReviewPageScreen extends StatefulWidget {
  const EmployeeReviewPageScreen({super.key});

  @override
  State<EmployeeReviewPageScreen> createState() => _EmployeeReviewPageScreenState();
}

class _EmployeeReviewPageScreenState extends State<EmployeeReviewPageScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p8, horizontal: AppPadding.p16),
          child: EmployeeReviewItemCard(),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../app/state_renderer/state_renderer_impl.dart';

class FilterCenterBottomSheet extends StatefulWidget {
  const FilterCenterBottomSheet({super.key});

  @override
  State<FilterCenterBottomSheet> createState() => _FilterCenterBottomSheetState();
}

class _FilterCenterBottomSheetState extends State<FilterCenterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("MAMM"),
    );
  }
}

import 'package:flutter/material.dart';

import '../resources/colorManager.dart';
import '../resources/fontManager.dart';
import '../resources/styleManager.dart';
import '../resources/valuesManager.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({
    Key? key,
    required this.title,
    this.initialValue = false,
    this.onChanged,
  }) : super(key: key);

  final String title;
  final bool initialValue;
  final Function(bool)? onChanged;

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 0.90,
          child: Checkbox(
            value: isChecked,
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  isChecked = val;
                });
                widget.onChanged?.call(val);
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s4),
            ),
            activeColor: ColorManager.colorRedB5,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: AppPadding.p2),
            child: Text(
              widget.title,
              style: getRegularStyle(
                color: ColorManager.colorBlack_0D,
                fontSize: AppSize.s12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:beauty_car/resources/fontManager.dart';
import 'package:beauty_car/resources/styleManager.dart';
import 'package:beauty_car/resources/valuesManager.dart';
import 'package:flutter/material.dart';

import '../../../resources/colorManager.dart';

class ReserveDetailsItem extends StatelessWidget {
  ReserveDetailsItem({super.key,required this.title , required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:AppPadding.p10,vertical: AppPadding.p10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: getRegularStyle(color: ColorManager.colorGray77,fontSize: FontSize.size16)),
          Text(value,style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.size16)),
        ],
      ),
    );
  }
}

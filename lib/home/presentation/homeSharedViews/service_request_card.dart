import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/fontManager.dart';
import 'package:beauty_car/resources/styleManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/colorManager.dart';
import '../../../resources/valuesManager.dart';

class ServiceRequestCard extends StatelessWidget {
  const ServiceRequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s18)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Padding(
           padding: const EdgeInsets.only(top: AppPadding.p24,bottom: AppPadding.p24,left: AppPadding.p16,right: AppPadding.p16),
           child: SvgPicture.asset(ImageAssets.avatarIcon),
         ),
          Padding(
            padding: const EdgeInsets.only(top: AppPadding.p28,bottom: AppPadding.p28,left: AppPadding.p4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mamdouh",style: getBoldStyle(color: ColorManager.colorGray72,fontSize: FontSize.size16)),
                const SizedBox(height: AppSize.s4),
                Text("مغاسل السيارات",style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.size16))
              ],
            ),
          )
        ],
      ),
    );
  }
}

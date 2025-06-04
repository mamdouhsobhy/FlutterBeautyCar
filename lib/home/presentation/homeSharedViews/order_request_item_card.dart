import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/fontManager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:beauty_car/resources/styleManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/colorManager.dart';
import '../../../resources/valuesManager.dart';

class OrderRequestItemCard extends StatelessWidget {
  const OrderRequestItemCard({super.key,required this.fun});

  final Function fun;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        fun();
      },
      child: Card(
        color: ColorManager.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s18)
        ),
        child: Column(
          children: [
            const SizedBox(height: AppSize.s20),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: AppPadding.p16,right: AppPadding.p16),
                      child: SvgPicture.asset(ImageAssets.avatarIcon),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: AppPadding.p4),
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
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: AppPadding.p8,left: AppPadding.p8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("67fd9ba3b",style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.size16)),
                          const SizedBox(height: AppSize.s4),
                          Text("4/9/2025",style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.size12))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: AppSize.s16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle accept
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.colorGreen34,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20, vertical: AppPadding.p12),
                      ),
                      icon: const Icon(Icons.check_circle, color: Colors.white, size: AppSize.s20),
                      label: Text(
                        AppStrings.accept.tr(),
                        style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.size16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Handle reject
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: ColorManager.colorRedB2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      icon: Icon(Icons.cancel, color: ColorManager.colorRedB2, size: 20),
                      label: Text(
                        AppStrings.reject.tr(),
                        style: getBoldStyle(color: ColorManager.colorRedB2,fontSize: FontSize.size16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.s20),
          ],
        ),
      ),
    );
  }
}

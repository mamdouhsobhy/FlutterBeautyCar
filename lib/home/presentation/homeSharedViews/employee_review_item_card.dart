import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../resources/assetsManager.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/fontManager.dart';
import '../../../resources/stringManager.dart';
import '../../../resources/styleManager.dart';
import '../../../resources/valuesManager.dart';

class EmployeeReviewItemCard extends StatelessWidget {
  const EmployeeReviewItemCard({super.key});

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
            padding: const EdgeInsets.only(top: AppPadding.p24,bottom: AppPadding.p24,left: AppPadding.p12),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                    width: AppSize.s60,
                    height: AppSize.s60,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: SvgPicture.asset(ImageAssets.avatarIcon,
                        fit: BoxFit.cover))
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: AppPadding.p28,bottom: AppPadding.p28,right: AppPadding.p8,left: AppPadding.p4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Mamdouh",style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.size16)),
                      Row(
                        children: [
                          Text("4.5",style: getRegularStyle(color: ColorManager.colorGray60,fontSize: FontSize.size12)),
                          Text(" "),
                          SvgPicture.asset(ImageAssets.starIcon)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: AppSize.s4),
                  Text("12/5/2025",style: getRegularStyle(color: ColorManager.colorGray72,fontSize: FontSize.size14)),
                  const SizedBox(height: AppSize.s4),
                  Text("Good",style: getRegularStyle(color: ColorManager.colorGray72,fontSize: FontSize.size14)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

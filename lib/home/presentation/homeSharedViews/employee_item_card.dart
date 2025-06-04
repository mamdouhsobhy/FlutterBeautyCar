import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/assetsManager.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/fontManager.dart';
import '../../../resources/stringManager.dart';
import '../../../resources/styleManager.dart';
import '../../../resources/valuesManager.dart';

class EmployeeItemCard extends StatelessWidget {
  const EmployeeItemCard({super.key,required this.fun});

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
                      width: AppSize.s80,
                      height: AppSize.s80,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: SvgPicture.asset(ImageAssets.avatarIcon,
                          fit: BoxFit.cover)),
                  GestureDetector(
                    onTap: () {
                      // Handle image edit action
                    },
                    child: Card(
                      color: ColorManager.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s30)
                      ),
                      child: Container(
                        width: AppSize.s30,
                        height: AppSize.s30,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Icon(Icons.edit,
                            size: AppSize.s18, color: ColorManager.colorRedB2),
                      ),
                    ),
                  ),
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
                        Text(AppStrings.identifier.tr(),style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.size16)),
                        Text("1232124121",style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.size16)),
                      ],
                    ),
                    const SizedBox(height: AppSize.s4),
                    Text("mohamed@gmail.com",style: getRegularStyle(color: ColorManager.colorGray72,fontSize: FontSize.size14)),
                    const SizedBox(height: AppSize.s4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("283 ${AppStrings.assignmentsCount.tr()}",style: getRegularStyle(color: ColorManager.colorGray72,fontSize: FontSize.size14)),
                        Row(
                          children: [
                            Text("4.5",style: getRegularStyle(color: ColorManager.colorGray60,fontSize: FontSize.size12)),
                            Text(" "),
                            SvgPicture.asset(ImageAssets.starIcon),
                            Text("45 ${AppStrings.reviews.tr()}",style: getRegularStyle(color: ColorManager.colorGray72,fontSize: FontSize.size14)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

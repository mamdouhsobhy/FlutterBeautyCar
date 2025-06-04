import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/assetsManager.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/fontManager.dart';
import '../../../resources/stringManager.dart';
import '../../../resources/styleManager.dart';
import '../../../resources/valuesManager.dart';

class HomeCenterOutsideServices extends StatelessWidget {
  const HomeCenterOutsideServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:AppPadding.p16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
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
                    padding: const EdgeInsets.only(top: AppPadding.p20,bottom: AppPadding.p20,left: AppPadding.p4,right: AppPadding.p4),
                    child: Row(
                      children: [
                        SvgPicture.asset(ImageAssets.serviceInCenterIcon,width: AppSize.s40,height: AppSize.s40,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppPadding.p20,bottom: AppPadding.p20,left: AppPadding.p2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.serviceInCenter.tr(),style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.size12)),
                        SizedBox(height: AppSize.s4,),
                        Text("18 "+AppStrings.order.tr(),style: getRegularStyle(color: ColorManager.colorGray72,fontSize: FontSize.size12)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
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
                    padding: const EdgeInsets.only(top: AppPadding.p20,bottom: AppPadding.p20,left: AppPadding.p4,right: AppPadding.p4),
                    child: Row(
                      children: [
                        SvgPicture.asset(ImageAssets.serviceOutSideIcon,width: AppSize.s40,height: AppSize.s40,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppPadding.p20,bottom: AppPadding.p20,left: AppPadding.p2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.serviceOutside.tr(),style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.size12)),
                        SizedBox(height: AppSize.s4,),
                        Text("2 "+AppStrings.order.tr(),style: getRegularStyle(color: ColorManager.colorGray72,fontSize: FontSize.size12)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../resources/colorManager.dart';
import '../../../resources/fontManager.dart';
import '../../../resources/stringManager.dart';
import '../../../resources/styleManager.dart';
import '../../../resources/valuesManager.dart';

class HomeCompleteService extends StatelessWidget {
  HomeCompleteService({super.key, required this.completedService});

  String completedService;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:AppPadding.p16),
      child: Card(
        color: ColorManager.colorRedB2,
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s18)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: AppPadding.p20,bottom: AppPadding.p20,left: AppPadding.p16,right: AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.todayServices.tr(),style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.size16)),
                  SizedBox(height: AppSize.s10,),
                  Text(AppStrings.completedServices.tr(),style: getRegularStyle(color: ColorManager.white,fontSize: FontSize.size16)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppPadding.p20,bottom: AppPadding.p20,left: AppPadding.p16,right: AppPadding.p16),
              child: Row(
                children: [
                  Text(completedService,style: getRegularStyle(color: ColorManager.white,fontSize: FontSize.size16)),
                  Text(" "),
                  Text(AppStrings.order.tr(),style: getRegularStyle(color: ColorManager.white,fontSize: FontSize.size16)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

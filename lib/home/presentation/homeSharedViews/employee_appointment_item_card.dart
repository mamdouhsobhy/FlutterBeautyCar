import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../resources/assetsManager.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/fontManager.dart';
import '../../../resources/stringManager.dart';
import '../../../resources/styleManager.dart';
import '../../../resources/valuesManager.dart';

class EmployeeAppointmentItemCard extends StatelessWidget {
  const EmployeeAppointmentItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s18)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: AppPadding.p24,
                bottom: AppPadding.p24,
                left: AppPadding.p12),
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
              padding: const EdgeInsets.only(
                  top: AppPadding.p28,
                  bottom: AppPadding.p28,
                  right: AppPadding.p8,
                  left: AppPadding.p4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Mamdouh",
                          style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.size16)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                        child: Text("Status : Completed",
                            style: getRegularStyle(
                                color: ColorManager.colorGray60,
                                fontSize: FontSize.size12)),
                      )
                    ],
                  ),
                  const SizedBox(height: AppSize.s4),
                  Text("67fd9ba3b",
                      style: getRegularStyle(
                          color: ColorManager.colorGray72,
                          fontSize: FontSize.size14)),
                  const SizedBox(height: AppSize.s4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Service Place : outside",
                          style: getRegularStyle(
                              color: ColorManager.colorGray72,
                              fontSize: FontSize.size14)),
                    ],
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

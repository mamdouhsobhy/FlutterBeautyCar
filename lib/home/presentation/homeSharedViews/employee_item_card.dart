import 'package:beauty_car/home/data/response/employees/employees.dart';
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
  const EmployeeItemCard({super.key,required this.fun,required this.employee});

  final Data employee;
  final Function(String , String) fun;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        fun("${employee.id}","details");
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
              padding: const EdgeInsets.only(top: AppPadding.p24,bottom: AppPadding.p24,left: AppPadding.p8,right: AppPadding.p8),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Card(
                    color: ColorManager.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s80)),
                    child: Container(
                        width: AppSize.s80,
                        height: AppSize.s80,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: ClipOval(
                          child: Image.network(
                            "${employee.image}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return SvgPicture.asset(ImageAssets.avatarIcon, fit: BoxFit.cover);
                            }
                          ),
                        ),
                    )
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: AppPadding.p24,bottom: AppPadding.p24,right: AppPadding.p8,left: AppPadding.p8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(AppStrings.identifier.tr(),style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.size16))),
                        Expanded(child: Text("${employee.ssdNum}",overflow: TextOverflow.ellipsis,maxLines: 1,style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.size16))),
                      ],
                    ),
                    const SizedBox(height: AppSize.s4),
                    Text("${employee.name}",overflow: TextOverflow.ellipsis,maxLines: 1,style: getRegularStyle(color: ColorManager.colorGray72,fontSize: FontSize.size14)),
                    const SizedBox(height: AppSize.s4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${employee.experiance} ${AppStrings.assignmentsCount.tr()}",style: getRegularStyle(color: ColorManager.colorGray72,fontSize: FontSize.size14)),
                        Row(
                          children: [
                            Text("${employee.rateEmployeeNum} ${AppStrings.reviews.tr()}",style: getRegularStyle(color: ColorManager.colorGray72,fontSize: FontSize.size14)),
                            Text(" "),
                            SvgPicture.asset(ImageAssets.starIcon),
                            Text(" ${employee.rateEmployeeStartNum}",style: getRegularStyle(color: ColorManager.colorGray60,fontSize: FontSize.size12)),
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

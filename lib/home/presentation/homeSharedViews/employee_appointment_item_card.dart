import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:beauty_car/utils/Constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../resources/assetsManager.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/fontManager.dart';
import '../../../resources/styleManager.dart';
import '../../../resources/valuesManager.dart';

class EmployeeAppointmentItemCard extends StatelessWidget {
  EmployeeAppointmentItemCard({super.key,required this.order , required this.fun});

  Data order;
  Function fun;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        fun(order.id);
      },
      child: Card(
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
                      child: SvgPicture.asset(ImageAssets.avatarIcon)
                  )
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
                        Text("${order.clientName}",
                            style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.size16)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                          child: Text("${AppStrings.status.tr()} : ${getStatus(order.status?.toInt() ?? 1)}",
                              style: getRegularStyle(
                                  color: ColorManager.colorGray60,
                                  fontSize: FontSize.size12)),
                        )
                      ],
                    ),
                    const SizedBox(height: AppSize.s4),
                    Text("${order.id}",
                        style: getRegularStyle(
                            color: ColorManager.colorGray72,
                            fontSize: FontSize.size14)),
                    const SizedBox(height: AppSize.s4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${AppStrings.serviceLocation.tr()} : ${order.placeType}",
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
      ),
    );
  }

  String getStatus(int status){
    if(status == OrderStatus.pending){
      return AppStrings.pending.tr();
    }else if(status == OrderStatus.accepted){
      return AppStrings.accepted.tr();
    }else if(status == OrderStatus.completed){
      return AppStrings.completed.tr();
    }else {
      return AppStrings.cancelled.tr();
    }
  }

}

import 'package:beauty_car/home/data/response/getRatedOrders/get_rated_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../resources/assetsManager.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/fontManager.dart';
import '../../../resources/styleManager.dart';
import '../../../resources/valuesManager.dart';

class EmployeeReviewItemCard extends StatelessWidget {
  EmployeeReviewItemCard({super.key,required this.ratedOrders,required this.fun});

  Data ratedOrders;
  Function fun;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        fun(ratedOrders.orderId);
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
              padding: const EdgeInsets.only(top: AppPadding.p24,bottom: AppPadding.p24,left: AppPadding.p12,right: AppPadding.p12),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: AppSize.s50,
                    height: AppSize.s50,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipOval(
                      child: Image.network(
                        "${ratedOrders.clientImage}",
                        errorBuilder: (context, error, stackTrace) {
                          return SvgPicture.asset(ImageAssets.avatarIcon);
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
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
                        Text("${ratedOrders.clientName}",style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.size16)),
                        Row(
                          children: [
                            Text("4.5",style: getRegularStyle(color: ColorManager.colorGray60,fontSize: FontSize.size12)),
                            Text(" "),
                            SvgPicture.asset(ImageAssets.starIcon),
                            SizedBox(width: 30),
                            Text("#${ratedOrders.orderId}",style: getBoldStyle(color: ColorManager.colorBlack10,fontSize: FontSize.size14)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: AppSize.s4),
                    Text("${ratedOrders.dateAdded}",style: getRegularStyle(color: ColorManager.colorGray72,fontSize: FontSize.size14)),
                    const SizedBox(height: AppSize.s4),
                    Text("${ratedOrders.comment}",style: getRegularStyle(color: ColorManager.colorGray72,fontSize: FontSize.size14)),
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

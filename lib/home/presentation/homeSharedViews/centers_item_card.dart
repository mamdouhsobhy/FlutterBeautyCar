import 'package:beauty_car/home/data/response/centers/centers.dart';
import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/fontManager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:beauty_car/resources/styleManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/colorManager.dart';
import '../../../resources/valuesManager.dart';

class CentersItemCard extends StatelessWidget {
  CentersItemCard({super.key,required this.centers,required this.fun});

  final Data centers;
  late Function fun;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s18)
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(AppSize.s18),topRight: Radius.circular(AppSize.s18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(centers.image ?? "",errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                ImageAssets.centerImageIcon, // Replace with your error image asset
                fit: BoxFit.cover,
                height: AppSize.s90,
                width: double.infinity,
              );
            },fit: BoxFit.cover,height: AppSize.s90,width: double.infinity),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p10),
              child: Text("${centers.name}",overflow: TextOverflow.ellipsis,maxLines: 1,style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.size14)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text("${centers.address}",overflow: TextOverflow.ellipsis,maxLines: 1,style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.size12))),
                  Row(
                    children: [
                      Text("4.5",style: getRegularStyle(color: ColorManager.colorGray60,fontSize: FontSize.size12)),
                      Text(" "),
                      SvgPicture.asset(ImageAssets.starIcon)
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10, vertical:  AppPadding.p2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s4), // Rounded corners
                      border:
                      Border.all(color: centers.status == 1 ? ColorManager.colorRedB2 :ColorManager.colorGreen34), // Optional: visible border
                    ),
                    child: Text(centers.status == 1 ?
                    AppStrings.closed.tr() : AppStrings.open.tr() ,style: getRegularStyle(color: centers.status == 1 ? ColorManager.colorRedB2 :ColorManager.colorGreen34,fontSize: FontSize.size14),),
                  ),
                ),
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      fun(centers.id);
                }, icon: SvgPicture.asset(ImageAssets.editIcon)
                ),
              ],
            ),
            const SizedBox(height: AppSize.s4,)
          ],
        ),
      ),
    );
  }
}

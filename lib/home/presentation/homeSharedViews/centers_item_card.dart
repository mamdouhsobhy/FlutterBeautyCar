import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/fontManager.dart';
import 'package:beauty_car/resources/styleManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/colorManager.dart';
import '../../../resources/valuesManager.dart';

class CentersItemCard extends StatelessWidget {
  CentersItemCard({super.key,required this.fun});

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
            Image.asset(ImageAssets.centerImageIcon,fit: BoxFit.cover,height: AppSize.s90,width: double.infinity),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p10),
              child: Text("Center Name",style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.size14)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Center Address",style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.size12)),
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
                      Border.all(color: ColorManager.colorGreen34), // Optional: visible border
                    ),
                    child: Text("Open",style: getRegularStyle(color: ColorManager.colorGreen34,fontSize: FontSize.size14),),
                  ),
                ),
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      fun();
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

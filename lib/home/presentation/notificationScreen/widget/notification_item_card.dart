import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resources/colorManager.dart';
import '../../../../resources/fontManager.dart';
import '../../../../resources/styleManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../data/response/getNotification/get_notification.dart';


class NotificationItemCard extends StatelessWidget {
  const NotificationItemCard({super.key,required this.notification,required this.fun});

  final NotifyData notification;

  final Function fun;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(notification.order_id != null) {
          fun(notification.order_id);
        }else{
          context.showInfoToast(AppStrings.this_order_not_available.tr());
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Card(
          color: ColorManager.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p24, horizontal: AppPadding.p16),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Card(
                      color: ColorManager.colorRedFA,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s80),
                      ),
                      child: Container(
                        width: AppSize.s50,
                        height: AppSize.s50,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: SvgPicture.asset(ImageAssets.clockIcon,width: 40,height: 40,fit: BoxFit.scaleDown,),
                      ),
                    )
                  ],
                ),
              ),
              Expanded( // ✅ make sure text column gets enough width
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p24, horizontal: AppPadding.p8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${notification.title}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.size16,
                        ),
                      ),
                      const SizedBox(height: AppSize.s4),
                      Text(
                        "${notification.body}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: getRegularStyle(
                          color: ColorManager.colorGray72,
                          fontSize: FontSize.size14,
                        ),
                      ),
                      const SizedBox(height: AppSize.s4),
                      Text(
                        formatArabicDateTime("${notification.date}"),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: getRegularStyle(
                          color: ColorManager.colorGray72,
                          fontSize: FontSize.size14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatArabicDateTime(String rawDateTime) {
    final dateTime = DateTime.parse(rawDateTime);

    // Format date as "8 يوليو، 2025"
    final formattedDate = DateFormat("d MMMM، yyyy", "ar").format(dateTime);

    // Format time as "08:58 ص"
    final formattedTime = DateFormat("hh:mm a", "ar").format(dateTime);

    return "$formattedDate - $formattedTime";
  }
}

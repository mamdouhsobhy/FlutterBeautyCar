import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/fontManager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:beauty_car/resources/styleManager.dart';
import 'package:beauty_car/utils/Constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/colorManager.dart';
import '../../../resources/valuesManager.dart';
import '../../../utils/shared_button.dart';
import '../../../utils/shared_text_field.dart';

class OrderScanItemCard extends StatefulWidget {
  OrderScanItemCard({super.key,required this.orders,required this.fun});

  final Data orders;
  late Function(Data , String) fun;

  @override
  State<OrderScanItemCard> createState() => _OrderScanItemCardState();
}

class _OrderScanItemCardState extends State<OrderScanItemCard> {
  final TextEditingController _reasonController = TextEditingController();

  bool _isReject = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.fun(widget.orders,"details");
      },
      child: Card(
        color: ColorManager.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s18)
        ),
        child: Column(
          children: [
            const SizedBox(height: AppSize.s20),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: AppPadding.p16,right: AppPadding.p16),
                        child: Container(
                          width: AppSize.s50,
                          height: AppSize.s50,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: ClipOval(
                            child: Image.network(
                              "${widget.orders.client_image_path}",
                              errorBuilder: (context, error, stackTrace) {
                                return SvgPicture.asset(ImageAssets.avatarIcon);
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: AppPadding.p4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${widget.orders.clientName}",style: getBoldStyle(color: ColorManager.colorGray72,fontSize: FontSize.size16)),
                              const SizedBox(height: AppSize.s4),
                              Text(widget.orders.serviceName ?? "------",maxLines: 1,overflow: TextOverflow.ellipsis,style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.size16))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: AppPadding.p8,left: AppPadding.p8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${widget.orders.id}",style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.size16)),
                          const SizedBox(height: AppSize.s4),
                          Text("${widget.orders.date}",style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.size12)),
                          const SizedBox(height: AppSize.s4),
                          InkWell(onTap: (){
                            widget.fun(widget.orders,"scan");
                          },child: Image.asset(ImageAssets.qrCodeIcon,width: 30,height: 30))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: AppSize.s16),
          ],
        ),
      ),
    );
  }
}

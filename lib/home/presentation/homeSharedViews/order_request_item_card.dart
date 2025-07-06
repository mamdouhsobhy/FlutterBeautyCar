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

class OrderRequestItemCard extends StatefulWidget {
  OrderRequestItemCard({super.key,required this.orders,required this.fun});

  final Data orders;
  late Function(String , String , String) fun;

  @override
  State<OrderRequestItemCard> createState() => _OrderRequestItemCardState();
}

class _OrderRequestItemCardState extends State<OrderRequestItemCard> {
  final TextEditingController _reasonController = TextEditingController();

  bool _isReject = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.fun("${widget.orders.id}","","details");
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: AppPadding.p16,right: AppPadding.p16),
                      child: SvgPicture.asset(ImageAssets.avatarIcon),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: AppPadding.p4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${widget.orders.clientName}",style: getBoldStyle(color: ColorManager.colorGray72,fontSize: FontSize.size16)),
                          const SizedBox(height: AppSize.s4),
                          Text(widget.orders.serviceName ?? "------",style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.size16))
                        ],
                      ),
                    )
                  ],
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
                          Text("${widget.orders.date}",style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.size12))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: AppSize.s16),
            if (widget.orders.status == OrderStatus.pending) Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        widget.fun("${widget.orders.id}","","accept");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.colorGreen34,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20, vertical: AppPadding.p12),
                      ),
                      icon: const Icon(Icons.check_circle, color: Colors.white, size: AppSize.s20),
                      label: Text(
                        AppStrings.accept.tr(),
                        style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.size16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isReject = true;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: ColorManager.colorRedB2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      icon: Icon(Icons.cancel, color: ColorManager.colorRedB2, size: 20),
                      label: Text(
                        AppStrings.reject.tr(),
                        style: getBoldStyle(color: ColorManager.colorRedB2,fontSize: FontSize.size16),
                      ),
                    ),
                  ),
                ],
              ),
            ) else SizedBox(),
            _isReject ? Column(
              children: [
                MyTextField(
                    hint: AppStrings.reject_reason.tr(),
                    title: "",
                    suffixIcon: "",
                    obscureText: false,
                    inputType: TextInputType.text,
                    validator: null,
                    controller: _reasonController,
                    takeValue: (value) {
                      _reasonController.text = value;
                    }),
                MyButton(
                  color: ColorManager.colorRedB2,
                  buttonText: AppStrings.reject.tr(),
                  paddingVertical: AppPadding.p0,
                  fun: () {
                    widget.fun("${widget.orders.id}",_reasonController.text,"reject");
                  },
                )
              ],
            ):SizedBox(),
            SizedBox(height: widget.orders.status == OrderStatus.pending ? AppSize.s20 : 0),
          ],
        ),
      ),
    );
  }
}

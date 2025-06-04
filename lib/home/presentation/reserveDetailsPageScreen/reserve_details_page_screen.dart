import 'package:beauty_car/home/presentation/homeSharedViews/reserve_details_item.dart';
import 'package:beauty_car/resources/fontManager.dart';
import 'package:beauty_car/resources/styleManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../resources/colorManager.dart';
import '../../../resources/stringManager.dart';
import '../../../resources/valuesManager.dart';
import '../../../utils/shared_appbar.dart';

class ReserveDetailsPageScreen extends StatefulWidget {
  const ReserveDetailsPageScreen({super.key});

  @override
  State<ReserveDetailsPageScreen> createState() =>
      _ReserveDetailsPageScreenState();
}

class _ReserveDetailsPageScreenState extends State<ReserveDetailsPageScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: ColorManager.white,
          appBar: MyAppBar(title: AppStrings.reserveDetails.tr()),
          body: SafeArea(
              child:
                  // StreamBuilder<FlowState>(
                  //   stream: _loginViewModel.outputState,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.data != null) {
                  //       _handleLoginStateChanged(snapshot.data!);
                  //     }
                  _getReserveDetailsScreenContent()
              // },
              // ),
              ),
        ));
  }

  Widget _getReserveDetailsScreenContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: AppSize.s20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.status.tr(),
                    style: getBoldStyle(
                        color: ColorManager.colorRedB2,
                        fontSize: FontSize.size18)),
                const SizedBox(width: AppSize.s6),
                Card(
                    color: ColorManager.colorGrayE4,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s4)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p12,vertical: AppPadding.p4),
                      child: Text("منتظر",
                          style: getMediumStyle(
                              color: ColorManager.colorGray77,
                              fontSize: FontSize.size18)),
                    ))
              ],
            ),
            const SizedBox(height: AppSize.s25),
            Text(AppStrings.carType.tr(),
                style: getBoldStyle(
                    color: ColorManager.colorRedB2,
                    fontSize: FontSize.size18)),
            const SizedBox(height: AppSize.s4),
        Card(
          color: ColorManager.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s4)),
          child: Column(
            children: [
              ReserveDetailsItem(title: AppStrings.carModel.tr(), value: "x5"),
              Divider(height: AppSize.s1,color: ColorManager.colorGrayD6,),
              ReserveDetailsItem(title: AppStrings.chassisNumber.tr(), value: "NJ-1234"),
              Divider(height: AppSize.s1,color: ColorManager.colorGrayD6,),
              ReserveDetailsItem(title: AppStrings.color.tr(), value: "ذهبى")
            ],
          )
        ),
            const SizedBox(height: AppSize.s25),
            Text(AppStrings.reserveDetails.tr(),
                style: getBoldStyle(
                    color: ColorManager.colorRedB2,
                    fontSize: FontSize.size18)),
            const SizedBox(height: AppSize.s4),
            Card(
                color: ColorManager.white,
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s4)),
                child: Column(
                  children: [
                    ReserveDetailsItem(title: AppStrings.centerName.tr(), value: "x5"),
                    Divider(height: AppSize.s1,color: ColorManager.colorGrayD6,),
                    ReserveDetailsItem(title: AppStrings.orderId.tr(), value: "NJ-1234"),
                    Divider(height: AppSize.s1,color: ColorManager.colorGrayD6,),
                    ReserveDetailsItem(title: AppStrings.date.tr(), value: "ذهبى"),
                    Divider(height: AppSize.s1,color: ColorManager.colorGrayD6,),
                    ReserveDetailsItem(title: AppStrings.time.tr(), value: "ذهبى"),
                    Divider(height: AppSize.s1,color: ColorManager.colorGrayD6,),
                    ReserveDetailsItem(title: AppStrings.address.tr(), value: "ذهبى")
                  ],
                )
            ),
            const SizedBox(height: AppSize.s25),
            Text(AppStrings.serviceDetails.tr(),
                style: getBoldStyle(
                    color: ColorManager.colorRedB2,
                    fontSize: FontSize.size18)),
            const SizedBox(height: AppSize.s4),
            Card(
                color: ColorManager.white,
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s4)),
                child: Column(
                  children: [
                    ReserveDetailsItem(title: AppStrings.serviceLocation.tr(), value: "x5"),
                    Divider(height: AppSize.s1,color: ColorManager.colorGrayD6,),
                    ReserveDetailsItem(title: AppStrings.serviceName.tr(), value: "NJ-1234"),
                  ],
                )
            ),
            const SizedBox(height: AppSize.s25),
            Text(AppStrings.customerDetails.tr(),
                style: getBoldStyle(
                    color: ColorManager.colorRedB2,
                    fontSize: FontSize.size18)),
            const SizedBox(height: AppSize.s4),
            Card(
                color: ColorManager.white,
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s4)),
                child: Column(
                  children: [
                    ReserveDetailsItem(title: AppStrings.name.tr(), value: "x5"),
                  ],
                )
            ),
            const SizedBox(height: AppSize.s25),
          ],
        ),
      ),
    );
  }
}

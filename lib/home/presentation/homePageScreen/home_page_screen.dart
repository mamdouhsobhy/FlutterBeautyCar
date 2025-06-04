import 'package:beauty_car/resources/fontManager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../resources/assetsManager.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/styleManager.dart';
import '../../../resources/valuesManager.dart';
import '../homeSharedViews/home_center_outside_services.dart';
import '../homeSharedViews/home_complete_service.dart';
import '../homeSharedViews/home_page_app_bar.dart';
import '../homeSharedViews/service_request_card.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: ColorManager.white,
          body: SafeArea(
              child:
                  // StreamBuilder<FlowState>(
                  //   stream: _loginViewModel.outputState,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.data != null) {
                  //       _handleLoginStateChanged(snapshot.data!);
                  //     }
                  _getHomeScreenContent()
              // },
              // ),
              ),
        ));
  }

  Widget _getHomeScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        HomePageAppBar(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HomeCompleteService(),
                const SizedBox(height: AppSize.s13),
                HomeCenterOutsideServices(),
                const SizedBox(height: AppSize.s13),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.serviceRequests.tr(),
                          style: getBoldStyle(
                              color: ColorManager.black, fontSize: FontSize.size16)),
                      Text(AppStrings.more.tr(),
                          style: getRegularStyle(
                              color: ColorManager.colorRedB2,
                              fontSize: FontSize.size16))
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.s8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppPadding.p8, horizontal: AppPadding.p16),
                      child: ServiceRequestCard(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

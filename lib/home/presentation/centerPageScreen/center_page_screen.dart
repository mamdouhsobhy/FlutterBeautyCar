import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/colorManager.dart';
import '../../../resources/valuesManager.dart';
import '../../../utils/shared_appbar.dart';
import '../../../utils/shared_text_field.dart';
import '../homeSharedViews/centers_item_card.dart';
import '../homeSharedViews/service_request_card.dart';
import '../routeManager/home_routes_manager.dart';

class CenterPageScreen extends StatefulWidget {
  const CenterPageScreen({super.key});

  @override
  State<CenterPageScreen> createState() => _CenterPageScreenState();
}

class _CenterPageScreenState extends State<CenterPageScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: ColorManager.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: MyAppBar(title: AppStrings.centers.tr()),
          ),
          body: SafeArea(
              child:
                  // StreamBuilder<FlowState>(
                  //   stream: _loginViewModel.outputState,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.data != null) {
                  //       _handleLoginStateChanged(snapshot.data!);
                  //     }
                  _getCentersScreenContent()
              // },
              // ),
              ),
        ));
  }

  Widget _getCentersScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: AppSize.s10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppPadding.p10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s15), // Rounded corners
                  border:
                      Border.all(color: Colors.grey), // Optional: visible border
                ),
                child: SvgPicture.asset(ImageAssets.filterIcon),
              ),
              const SizedBox(width: AppSize.s10), // Optional: spacing between icon and text field
              Expanded(
                child: MyTextField(
                  hint: "",
                  title: "",
                  suffixIcon: ImageAssets.searchIcon,
                  obscureText: false,
                  inputType: TextInputType.text,
                  controller: _searchController,
                  takeValue: (value) {},
                  validator: null,
                  paddingHorizontal: AppPadding.p0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s10,),
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14,vertical: AppPadding.p5),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two items per row
                    mainAxisSpacing: AppPadding.p8,
                    crossAxisSpacing: AppPadding.p8,
                    childAspectRatio:1 / 1.3, // Adjust based on your card's height/width
                  ),
                  itemBuilder: (context, index) {
                    return CentersItemCard(fun: (){
                      Navigator.pushNamed(context, HomeRoutes.createCenterRoute);
                    });
                  },
                ),
              ),
              Positioned(
                bottom: AppPadding.p50,
                  right: AppPadding.p16,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, HomeRoutes.createCenterRoute);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(AppPadding.p10),
                      decoration: BoxDecoration(
                        color: ColorManager.colorRedB2, // Light gray background
                        borderRadius: BorderRadius.circular(AppSize.s15), // Rounded corners
                        border:
                        Border.all(color: ColorManager.colorRedB2), // Optional: visible border
                      ),
                      child: SvgPicture.asset(ImageAssets.plusIcon),
                    ),
                  )
              )
            ],
          ),
        )
      ],
    );
  }
}

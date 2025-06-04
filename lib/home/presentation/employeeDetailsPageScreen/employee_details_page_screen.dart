import 'package:beauty_car/resources/fontManager.dart';
import 'package:beauty_car/resources/styleManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/assetsManager.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/constantsManager.dart';
import '../../../resources/stringManager.dart';
import '../../../resources/valuesManager.dart';
import '../../../utils/shared_appbar.dart';
import '../employeeAppointmentPageScreen/employee_appointment_page_screen.dart';
import '../employeeInfoPageScreen/employee_info_page_screen.dart';
import '../employee_review_page_screen/employee_review_page_screen.dart';

class EmployeeDetailsPageScreen extends StatefulWidget {
  const EmployeeDetailsPageScreen({super.key});

  @override
  State<EmployeeDetailsPageScreen> createState() =>
      _EmployeeDetailsPageScreenState();
}

class _EmployeeDetailsPageScreenState extends State<EmployeeDetailsPageScreen> {
  final PageController _pageController = PageController();

  final List<String> pageList = [
    AppStrings.profile.tr(),
    AppStrings.appointment.tr(),
    AppStrings.review.tr(),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: ColorManager.white,
          appBar: MyAppBar(title: ""),
          body: SafeArea(
              child:
                  // StreamBuilder<FlowState>(
                  //   stream: _loginViewModel.outputState,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.data != null) {
                  //       _handleLoginStateChanged(snapshot.data!);
                  //     }
                  _getEmployeeDetailsScreenContent()
              // },
              // ),
              ),
        ));
  }

  Widget _getEmployeeDetailsScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: AppSize.s10),
        Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                  width: AppSize.s80,
                  height: AppSize.s80,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: SvgPicture.asset(ImageAssets.avatarIcon,
                      fit: BoxFit.cover)),
              GestureDetector(
                onTap: () {
                  // Handle image edit action
                },
                child: Card(
                  color: ColorManager.white,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s30)),
                  child: Container(
                    width: AppSize.s30,
                    height: AppSize.s30,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Icon(Icons.edit,
                        size: AppSize.s18, color: ColorManager.colorRedB2),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s6),
        Column(
          children: [
            Text("Mamdouh Sobhy",
                style: getBoldStyle(
                    color: ColorManager.black, fontSize: FontSize.size16)),
            Text("Ahmed@gmail.com",
                style: getRegularStyle(
                    color: ColorManager.colorGray72, fontSize: FontSize.size12))
          ],
        ),
        const SizedBox(height: AppSize.s10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(pageList.length, (index) {
          final isSelected = index == selectedIndex;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSize.s20),
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                _goToNextOrBackPage();
                print('Selected: ${pageList[index]}');
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p16, vertical: AppPadding.p12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorManager.colorRedB2 // Selected: Red
                      : ColorManager.colorRedFA, // Unselected: Light Red
                  borderRadius: BorderRadius.circular(AppSize.s8),
                ),
                child: Text(
                  pageList[index],
                  style: getRegularStyle(
                      fontSize: FontSize.size14,
                      color: isSelected ? Colors.white : Colors.black),
                ),
              ),
            ),
          );
        })
        ),
        const SizedBox(height: AppSize.s10)
        ,
        Expanded(
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: 3,
            onPageChanged: (index) {
            },
            itemBuilder: (ctx, index) {
              if(index == 0){
                return EmployeeInfoPageScreen();
              }
              if(index == 1){
                return EmployeeAppointmentPageScreen();
              }
              if(index == 2){
                return EmployeeReviewPageScreen();
              }
            },
          ),
        )
      ],
    );
  }

  _goToNextOrBackPage(){
    _pageController.animateToPage(
        selectedIndex,
        duration:
        const Duration(milliseconds: AppConstants
            .sliderAnimationTime),
        curve: Curves.bounceInOut);
  }
}

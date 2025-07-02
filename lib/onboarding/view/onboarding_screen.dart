import 'package:beauty_car/authentication/presentation/routeManager/authentication_screen.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:beauty_car/splash/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/di/di.dart';
import '../../../../resources/assetsManager.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../app/sharedPrefs/app_prefs.dart';
import '../../resources/constantsManager.dart';
import '../../resources/styleManager.dart';
import '../model/models.dart';
import '../viewmodel/onBoardingViewModel.dart';
import '../widget/onboarding_pages.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind(){
    _appPreferences.setOnBoardingScreenViewed();
    _viewModel.userType = "${_appPreferences.getUserType()}";
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return _getOnboardingContentPage(snapshot.data);
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget _getOnboardingContentPage(SliderViewObject? data) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: ColorManager.white,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: AppSize.s90),
                Expanded(
                  flex: 2,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: data?.numOfSliders,
                    onPageChanged: (index) {
                      _viewModel.onPageChanged(index);
                    },
                    itemBuilder: (ctx, index) {
                      return OnBoardingPage(sliderObject: data!.sliderObject);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              if(data?.currentIndex == 0) {
                                _goToNextPage();
                              } else {
                                _goToBackPage();
                              }
                            },
                            child: Text(
                              data?.currentIndex == 0 ? AppStrings.start.tr() : AppStrings.back.tr(),
                              style: getBoldStyle(color: ColorManager.colorRedB2, fontSize: AppSize.s16)
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < data!.numOfSliders; i++)
                                Padding(
                                  padding: const EdgeInsets.all(AppSize.s4),
                                  child: SvgPicture.asset(
                                    i == data.currentIndex
                                        ? ImageAssets.hollowCircleIc
                                        : ImageAssets.solidCircleIc
                                  ),
                                )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              if(data.currentIndex == 2) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => AuthenticationScreen()),
                                );
                              } else {
                                _goToNextPage();
                              }
                            },
                            child: Text(
                              data.currentIndex == 0 ? "" : AppStrings.next.tr(),
                              style: getBoldStyle(color: ColorManager.colorRedB2, fontSize: AppSize.s16)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.s30),
              ],
            ),
          ),
        )
    );
  }

  _goToNextPage(){
    _pageController.animateToPage(
        _viewModel.goToNextPage(),
        duration:
        const Duration(milliseconds: AppConstants
            .sliderAnimationTime),
        curve: Curves.bounceInOut);
  }

  _goToBackPage(){
    _pageController.animateToPage(
        _viewModel.goToBackPage(),
        duration:
        const Duration(milliseconds: AppConstants
            .sliderAnimationTime),
        curve: Curves.bounceInOut);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}


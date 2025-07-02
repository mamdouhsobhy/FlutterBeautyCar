
import 'dart:async';

import 'package:beauty_car/utils/Constants.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../resources/assetsManager.dart';
import '../../resources/stringManager.dart';
import '../model/models.dart';


class OnBoardingViewModel extends BaseViewModel implements OnBoardingViewModelInputs,OnBoardingViewModelOutputs{

  StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  String userType = UserTypes.owner;

  //baseViewModel inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    if(userType == UserTypes.owner) {
      _list = _getSliderData();
    }else{
      _list = _getSliderDataEmployee();
    }
    _postDataToView();
  }

  //onBoardingViewModel Inputs
  @override
  int goToBackPage() {
    if (_currentIndex != 0) {
      _currentIndex--;
    }
    return _currentIndex;
  }

  @override
  int goToNextPage() {
    if (_currentIndex != _list.length - 1) {
      _currentIndex++;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //onboarding viewModel outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);

  //onboarding private functions
  void _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

  @override
  bool isShowError = false;

   List<SliderObject> _getSliderData() => [
      SliderObject(AppStrings.onboardingTitle1.tr(), AppStrings.onboardingSubtitle1.tr(), ImageAssets.onboardingLogo1),
      SliderObject(AppStrings.onboardingTitle2.tr(), AppStrings.onboardingSubtitle2.tr(), ImageAssets.onboardingLogo2),
      SliderObject(AppStrings.onboardingTitle3.tr(), AppStrings.onboardingSubtitle3.tr(), ImageAssets.onboardingLogo3),
    ];

  List<SliderObject> _getSliderDataEmployee() => [
    SliderObject(AppStrings.onboarding_title_1_emp_2.tr(), AppStrings.onboarding_subtitle_1_emp_2.tr(), ImageAssets.onboardingLogo1Emp),
    SliderObject(AppStrings.onboarding_title_2_emp_2.tr(), AppStrings.onboarding_subtitle_2_emp_2.tr(), ImageAssets.onboardingLogo2Emp),
    SliderObject(AppStrings.onboarding_title_3_emp_2.tr(), AppStrings.onboarding_subtitle_3_emp_2.tr(), ImageAssets.onboardingLogo3Emp),
  ];

}

abstract class OnBoardingViewModelInputs{

  int goToNextPage();

  int goToBackPage();

  void onPageChanged(int index);

  Sink get inputSliderViewObject;

}

abstract class OnBoardingViewModelOutputs{
  Stream<SliderViewObject> get outputSliderViewObject;
}
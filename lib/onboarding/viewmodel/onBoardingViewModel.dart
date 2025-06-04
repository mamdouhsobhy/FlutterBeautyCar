
import 'dart:async';

import 'package:easy_localization/easy_localization.dart';

import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../resources/assetsManager.dart';
import '../../resources/stringManager.dart';
import '../model/models.dart';


class OnBoardingViewModel extends BaseViewModel implements OnBoardingViewModelInputs,OnBoardingViewModelOutputs{

  StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  //baseViewModel inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
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
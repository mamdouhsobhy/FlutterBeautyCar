import 'package:flutter/material.dart';
import '../../resources/colorManager.dart';
import '../../resources/styleManager.dart';
import '../../resources/valuesManager.dart';
import '../model/models.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key, required this.sliderObject});

  final SliderObject sliderObject;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: Image.asset(
                sliderObject.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  sliderObject.title,
                  textAlign: TextAlign.center,
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: AppSize.s18
                  ),
                ),
                const SizedBox(height: AppSize.s16),
                Text(
                  sliderObject.subTitle,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: getRegularStyle(
                    color: ColorManager.colorGray38,
                    fontSize: AppSize.s14
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
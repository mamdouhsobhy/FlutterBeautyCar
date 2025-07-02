import 'package:beauty_car/utils/Constants.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app/di/di.dart';
import '../app/sharedPrefs/app_prefs.dart';
import '../onboarding/view/onboarding_screen.dart';
import '../resources/colorManager.dart';
import '../resources/stringManager.dart';
import '../resources/valuesManager.dart';
import '../utils/shared_appbar.dart';
import '../utils/shared_button.dart';

class SelectUserTypePageScreen extends StatefulWidget {
  const SelectUserTypePageScreen({super.key});

  @override
  State<SelectUserTypePageScreen> createState() => _SelectUserTypePageScreenState();
}

class _SelectUserTypePageScreenState extends State<SelectUserTypePageScreen> {

  final AppPreferences _appPreferences = instance<AppPreferences>();

  bool _isVendorChecked = false;
  bool _isEmployeeChecked = false;

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
            child: MyAppBar(title: AppStrings.select_type.tr()),
          ),
          body: SafeArea(child: _getTypeScreenContent()),
        ));
  }

  _intentToOnBoarding(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  Widget _getTypeScreenContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListTile(
                leading: Checkbox(
                  value: _isVendorChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isVendorChecked = value ?? false;
                      _isEmployeeChecked = false;
                    });
                  },
                ),
                title: Text(AppStrings.owner.tr()),
              ),
            ),
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListTile(
                leading: Checkbox(
                  value: _isEmployeeChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isEmployeeChecked = value ?? false;
                      _isVendorChecked = false;
                    });
                  },
                ),
                title: Text(AppStrings.employee.tr()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40)
        ,
        MyButton(
          color: ColorManager.colorRedB2,
          buttonText: AppStrings.confirm.tr(),
          paddingVertical: AppPadding.p0,
          fun: () {
            if(_isEmployeeChecked){
              _appPreferences.setUserType(int.parse(UserTypes.employee));
              _intentToOnBoarding();
            }else if(_isVendorChecked) {
              _appPreferences.setUserType(int.parse(UserTypes.owner));
              _intentToOnBoarding();
            }else{
              context.showInfoToast(AppStrings.select_type.tr());
            }
          },
        )
      ],
    );
  }

}

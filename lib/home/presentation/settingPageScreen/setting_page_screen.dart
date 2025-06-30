import 'package:beauty_car/app/sharedPrefs/app_prefs.dart';
import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/languageManager.dart';
import 'package:beauty_car/resources/styleManager.dart';
import 'package:beauty_car/resources/valuesManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/di/di.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/stringManager.dart';
import '../../../utils/shared_appbar.dart';
import '../routeManager/home_routes_manager.dart';

class SettingPageScreen extends StatefulWidget {
  const SettingPageScreen({super.key});

  @override
  State<SettingPageScreen> createState() => _SettingPageScreenState();
}

class _SettingPageScreenState extends State<SettingPageScreen> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  bool _isNotifyChecked = false;
  bool _isEnglishChecked = false;
  bool _isArabicChecked = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeLanguagePreference();
  }

  void _initializeLanguagePreference() async {
    final appLanguage = await _appPreferences.getAppLanguage();
    setState(() {
      if (appLanguage == ENGLISH) {
        _isEnglishChecked = true;
      } else {
        _isArabicChecked = true;
      }
    });
  }

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
            child: MyAppBar(title: AppStrings.settings.tr()),
          ),
          body: SafeArea(child: _getSettingScreenContent()),
        ));
  }

  Widget _getSettingScreenContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, HomeRoutes.editProfileRoute);
            },
            child: Card(
                color: ColorManager.white,
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    SvgPicture.asset(ImageAssets.userIcon,color: ColorManager.colorRedB2,),
                    Text(" ${AppStrings.edit_profile.tr()} ",style: getSemiBoldStyle(color: ColorManager.colorBlack03,fontSize: AppSize.s16)),
                    Expanded(child: SizedBox()),
                    SvgPicture.asset(ImageAssets.arrowRightIcon,color: ColorManager.colorRedB2,)
                  ],),
                )
            ),
          ),
          const SizedBox(height: 10),
          Card(
              color: ColorManager.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageAssets.notificationIcon,color: ColorManager.colorRedB2,),
                    Text(" ${AppStrings.notification.tr()} ",style: getSemiBoldStyle(color: ColorManager.colorBlack03,fontSize: AppSize.s16)),
                    Expanded(child: SizedBox()),
                    SizedBox(
                      width: 50,
                      height: 30,
                      child: Switch(
                        inactiveThumbColor: ColorManager.colorRedB2,
                        activeTrackColor: ColorManager.colorRedB2,
                        activeColor: ColorManager.white,
                        value: _isNotifyChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _isNotifyChecked = value;
                          });
                        },
                      ),
                    )
                  ],),
              )
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: (){
              _showLanguageBottomSheet(context);
            },
            child: Card(
                color: ColorManager.white,
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImageAssets.langIcon,color: ColorManager.colorRedB2,),
                      Text(" ${AppStrings.lang_setting.tr()} ",style: getSemiBoldStyle(color: ColorManager.colorBlack03,fontSize: AppSize.s16)),
                      Expanded(child: SizedBox()),
                      SvgPicture.asset(ImageAssets.arrowRightIcon,color: ColorManager.colorRedB2,)
                    ],),
                )
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, HomeRoutes.changePasswordRoute);
            },
            child: Card(
                color: ColorManager.white,
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImageAssets.lockIcon,color: ColorManager.colorRedB2,),
                      Text(" ${AppStrings.change_password.tr()} ",style: getSemiBoldStyle(color: ColorManager.colorBlack03,fontSize: AppSize.s16)),
                      Expanded(child: SizedBox()),
                      SvgPicture.asset(ImageAssets.arrowRightIcon,color: ColorManager.colorRedB2,)
                    ],),
                )
            ),
          )
        ],
      ),
    );
  }

  _showLanguageBottomSheet(BuildContext context){
    showModalBottomSheet(context: context, builder: (BuildContext ctx){
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Checkbox(
                value: _isEnglishChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isEnglishChecked = value ?? false;
                    _appPreferences.changeAppLanguage(ENGLISH);
                    Phoenix.rebirth(context);
                  });
                },
              ),
              title: Text(AppStrings.english.tr()),
            ),
            ListTile(
              leading: Checkbox(
                value: _isArabicChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isArabicChecked = value ?? false;
                    _appPreferences.changeAppLanguage(ARABIC);
                    Phoenix.rebirth(context);
                  });
                },
              ),
              title: Text(AppStrings.arabic.tr()),
            ),
          ],
        ),
      );
    });
  }

}

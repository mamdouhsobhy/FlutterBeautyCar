import 'package:beauty_car/app/sharedPrefs/app_prefs.dart';
import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:beauty_car/home/presentation/settingPageScreen/viewmodel/setting_viewmodel.dart';
import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/languageManager.dart';
import 'package:beauty_car/resources/styleManager.dart';
import 'package:beauty_car/resources/valuesManager.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/stringManager.dart';
import '../../../../splash/splash_screen.dart';
import '../../../../utils/loading_page.dart';
import '../../../../utils/shared_appbar.dart';
import '../../routeManager/home_routes_manager.dart';

class SettingPageScreen extends StatefulWidget {
  const SettingPageScreen({super.key});

  @override
  State<SettingPageScreen> createState() => _SettingPageScreenState();
}

class _SettingPageScreenState extends State<SettingPageScreen> {

  final _firebaseMessaging = FirebaseMessaging.instance;

  final SettingViewModel _settingViewModel = instance<SettingViewModel>();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  ModelLoginResponseRemote? userDate;

  bool _isNotifyChecked = false;
  bool _isEnglishChecked = false;
  bool _isArabicChecked = false;
  String? fCMToken = "";
  int notifyType = 0;

  _bind() async {
    _settingViewModel.start();
    fCMToken = await _firebaseMessaging.getToken();
    print("FCM Token: $fCMToken");
  }

  @override
  void initState() {
    _settingViewModel.type = "${_appPreferences.getUserType()}";
    _bind();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeLanguagePreference();
  }

  void _initializeLanguagePreference() async {
    final appLanguage = await _appPreferences.getAppLanguage();
    if(userDate == null) {
      userDate = await _appPreferences.getUserData();
      notifyType = userDate?.data?.notificationStatus ?? 0;
      if(userDate?.data?.notificationStatus == 1){
        _isNotifyChecked = true;
      }else{
        _isNotifyChecked = false;
      }

    }

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
          body: SafeArea(
              child:
              StreamBuilder<FlowState>(
                stream: _settingViewModel.outputState,
                builder: (context, snapshot) {
                  if (snapshot.data != null && _settingViewModel.isOutStateLoading) {
                    _handleTermsAndConditionStateChanged(snapshot.data!);
                  }
                  return _getSettingScreenContent();
                },
              ),
          ),
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
                    Transform.rotate(angle: _isEnglishChecked ? 3.14 : 0.0,child: SvgPicture.asset(ImageAssets.arrowRightIcon,color: ColorManager.colorRedB2,))
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
                    StreamBuilder<ModelLoginResponseRemote>(
                        stream: _settingViewModel.outputUpdateNotifyData,
                        builder: (ctx, snapshot) {
                          if (snapshot.data != null && snapshot.data?.status == true) {
                            if(_settingViewModel.isUpdateLoading){
                              _settingViewModel.isUpdateLoading = false;
                              notifyType = snapshot.data?.data?.notificationStatus ?? 0;
                              userDate?.data?.notificationStatus = snapshot.data?.data?.notificationStatus;
                              _appPreferences.setUserData(userDate!);
                            }
                          }
                          return SizedBox(
                            width: 50,
                            height: 30,
                            child: Switch(
                              inactiveThumbColor: ColorManager.colorRedB2,
                              activeTrackColor: ColorManager.colorRedB2,
                              activeColor: ColorManager.white,
                              value: _isNotifyChecked,
                              onChanged: (bool value) {
                                _isNotifyChecked = value;
                                switchStatus();
                              },
                            ),
                          );
                        }),
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
                      Transform.rotate(angle: _isEnglishChecked ? 3.14 : 0.0,child: SvgPicture.asset(ImageAssets.arrowRightIcon,color: ColorManager.colorRedB2,))
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
                      Transform.rotate(angle: _isEnglishChecked ? 3.14 : 0.0,child: SvgPicture.asset(ImageAssets.arrowRightIcon,color: ColorManager.colorRedB2,))
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SplashScreen()),
                    );
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SplashScreen()),
                    );
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

  switchStatus() {
    if (_isNotifyChecked) {
      _settingViewModel.updateNotify("$fCMToken");
    } else {
      _settingViewModel.updateNotify("");
    }
  }

  _handleTermsAndConditionStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _settingViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _settingViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _settingViewModel.dispose();
    super.dispose();
  }

}

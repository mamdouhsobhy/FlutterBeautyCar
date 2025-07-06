import 'package:beauty_car/app/sharedPrefs/app_prefs.dart';
import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:beauty_car/home/presentation/routeManager/home_routes_manager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../resources/assetsManager.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/fontManager.dart';
import '../../../../resources/styleManager.dart';
import '../../../../resources/valuesManager.dart';

class SideMenu extends StatefulWidget {
  SideMenu({super.key, required this.appPreferences,required this.fun});

  AppPreferences appPreferences;
  Function(int) fun;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  ModelLoginResponseRemote? userData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUserData();
  }

  void _loadUserData() async {
    final data = await widget.appPreferences.getUserData();
    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.colorGrayF3,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Card(
            margin: const EdgeInsets.all(0),
            elevation: 1,
            child: Container(
              color: ColorManager.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: AppPadding.p24,
                            bottom: AppPadding.p24,
                            left: AppPadding.p16,
                            right: AppPadding.p16),
                        child: SvgPicture.asset(ImageAssets.avatarIcon),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: AppPadding.p24,
                            bottom: AppPadding.p24,
                            left: AppPadding.p4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${AppStrings.welcomeMessage.tr()} ${userData?.data?.name}",
                                style: getBoldStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.size14)),
                            const SizedBox(height: AppSize.s4),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < (5 ?? 0)
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: ColorManager.colorYellowF9,
                                  size: FontSize.size16,
                                );
                              }),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.centerIcon),
            title: Text(AppStrings.centers.tr(),
                style: getRegularStyle(
                    color: ColorManager.black, fontSize: AppSize.s16)),
            onTap: () {
              widget.fun(1);
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.ordersIcon),
            title: Text(AppStrings.orders.tr(),
                style: getRegularStyle(
                    color: ColorManager.black, fontSize: AppSize.s16)),
            onTap: () {
              widget.fun(2);
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.usersIcon),
            title: Text(AppStrings.employees.tr(),
                style: getRegularStyle(
                    color: ColorManager.black, fontSize: AppSize.s16)),
            onTap: () {
              widget.fun(3);
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.waitIcon),
            title: Text(AppStrings.wait_appointment.tr(),
                style: getRegularStyle(
                    color: ColorManager.black, fontSize: AppSize.s16)),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.pushNamed(context, HomeRoutes.employeeAppointmentRoute);
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.notificationIcon),
            title: Text(AppStrings.notification.tr(),
                style: getRegularStyle(
                    color: ColorManager.black, fontSize: AppSize.s16)),
            onTap: () {

              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.settingIcon),
            title: Text(AppStrings.settings.tr(),
                style: getRegularStyle(
                    color: ColorManager.black, fontSize: AppSize.s16)),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.pushNamed(context, HomeRoutes.settingsRoute);
            },
          ),
          ListTile(
            title: Text(AppStrings.privacy_policy.tr(),
                style: getRegularStyle(
                    color: ColorManager.black, fontSize: AppSize.s16)),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.pushNamed(context, HomeRoutes.privacyPolicyRoute);
              },
          ),
          ListTile(
            title: Text(AppStrings.terms_and_condition.tr(),
                style: getRegularStyle(
                    color: ColorManager.black, fontSize: AppSize.s16)),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.pushNamed(context, HomeRoutes.termsAndConditionRoute);
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.logoutIcon),
            title: Text(AppStrings.logout.tr(),
                style: getRegularStyle(
                    color: ColorManager.colorRedB2, fontSize: AppSize.s16)),
            onTap: () async {
              await widget.appPreferences
                  .setUserData(ModelLoginResponseRemote());
              await widget.appPreferences.setUserLoggedIn(false);
              Phoenix.rebirth(context);
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.deleteIcon),
            title: Text(AppStrings.delete_account.tr(),
                style: getRegularStyle(
                    color: ColorManager.colorRedB2, fontSize: AppSize.s16)),
            onTap: () async {
              Navigator.pop(context); // Close drawer
              Navigator.pushNamed(context, HomeRoutes.deleteAccountRoute);
            },
          )
        ],
      ),
    );
  }
}

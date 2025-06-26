import 'package:beauty_car/home/presentation/routeManager/home_routes_manager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resources/assetsManager.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/fontManager.dart';
import '../../../../resources/styleManager.dart';
import '../../../../resources/valuesManager.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.colorGrayF3,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: ColorManager.colorRedB2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p24, bottom: AppPadding.p24, left: AppPadding.p16, right: AppPadding.p16),
                      child: SvgPicture.asset(ImageAssets.avatarIcon),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p24, bottom: AppPadding.p24, left: AppPadding.p4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Welcome Mamdouh", style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.size14)),
                          const SizedBox(height: AppSize.s4),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < (5 ?? 0) ? Icons.star : Icons.star_border,
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
          ListTile(
            leading: SvgPicture.asset(ImageAssets.centerIcon),
            title: Text(AppStrings.centers.tr()),
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.searchIcon),
            title: Text(AppStrings.services.tr()),
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.usersIcon),
            title: Text(AppStrings.employees.tr()),
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.usersIcon),
            title: Text(AppStrings.employees.tr()),
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.notificationIcon),
            title: Text(AppStrings.employees.tr()),
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.notificationIcon),
            title: Text(AppStrings.employees.tr()),
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          )
        ],
      ),
    );
  }

}

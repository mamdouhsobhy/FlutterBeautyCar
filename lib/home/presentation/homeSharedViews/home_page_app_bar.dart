import 'package:beauty_car/home/presentation/routeManager/home_routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/assetsManager.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/fontManager.dart';
import '../../../resources/valuesManager.dart';

class HomePageAppBar extends StatelessWidget {
   HomePageAppBar({super.key,required this.scafoldKey, required this.unReadNotify});
  GlobalKey<ScaffoldState> scafoldKey;
  String unReadNotify;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                scafoldKey.currentState!.openDrawer();
              },
              child: SvgPicture.asset(ImageAssets.menuIcon)
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, HomeRoutes.notificationRoute);
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(ImageAssets.notificationIcon),
                  Positioned(
                    right: -4, // Adjust position as needed
                    top: -8,   // Adjust position as needed
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: ColorManager.colorRedB2, // Badge color
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        unReadNotify, // Replace with your dynamic counter value
                        style: const TextStyle(
                          color: Colors.white, // Text color
                          fontSize: FontSize.size12,       // Font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

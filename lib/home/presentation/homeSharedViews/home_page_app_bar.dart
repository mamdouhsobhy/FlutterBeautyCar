import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/assetsManager.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/fontManager.dart';
import '../../../resources/valuesManager.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, "");
              },
              child: SvgPicture.asset(ImageAssets.menuIcon)
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "");
            },
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
                    child: const Text(
                      '3', // Replace with your dynamic counter value
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: FontSize.size12,       // Font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

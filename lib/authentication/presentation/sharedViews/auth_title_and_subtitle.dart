import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/colorManager.dart';
import 'package:beauty_car/resources/styleManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/fontManager.dart';

class AuthTitleAndSubTitle extends StatelessWidget {
  const AuthTitleAndSubTitle(
      {super.key, required this.title, required this.subTitle , this.isShowImage = false});

  final String title;
  final String subTitle;
  final bool isShowImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: getBoldStyle(color: ColorManager.colorBlack33,fontSize: FontSize.size16)),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              subTitle,
              maxLines: 2,
              style: getRegularStyle(color: ColorManager.colorBlack03,fontSize: FontSize.size16),
            ),
            Text(" "),
            isShowImage ? SvgPicture.asset(ImageAssets.handIcon) : Text("")
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/assetsManager.dart';
import '../resources/colorManager.dart';
import '../resources/fontManager.dart';
import '../resources/languageManager.dart';
import '../resources/styleManager.dart';
import '../resources/valuesManager.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  MyAppBar({super.key,required this.title});

  late String title;

  @override
  Widget build(BuildContext context) {
    final isArabic = LanguageManager.getCurrentLanguage(context) == ARABIC;

    return AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: title.isEmpty ? false : true,
        title: Text(title,style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s20)),
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: ColorManager.white,
        leading: title.isEmpty ? Transform.rotate(
          angle: isArabic ? 3.14 : 0.0,
          child: IconButton(
            icon: SvgPicture.asset(ImageAssets.arrowBackIcon,color: ColorManager.colorBlack03,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ): null
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

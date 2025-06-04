import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../resources/styleManager.dart';
import '../resources/valuesManager.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.color,
    required this.buttonText,
    required this.fun,
    this.buttonTextColor = Colors.white,
    this.paddingHorizontal = AppPadding.p16,
    this.paddingVertical = AppPadding.p20,
  }) : super(key: key);

  final Color color;
  final String buttonText;
  final Color buttonTextColor;
  final VoidCallback fun;
  final double paddingHorizontal;
  final double paddingVertical;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      child: MaterialButton(
        color: color,
        height: AppSize.s50,
        splashColor: color.withOpacity(0.2),
        onPressed: fun,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: getBoldStyle(
                  color: buttonTextColor,
                  fontSize: AppSize.s16
              ),
            )
          ],
        ),
      ),
    );
  }
}

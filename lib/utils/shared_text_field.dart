import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../resources/assetsManager.dart';
import '../resources/colorManager.dart';
import '../resources/fontManager.dart';
import '../resources/languageManager.dart';
import '../resources/styleManager.dart';
import '../resources/valuesManager.dart';

class MyTextField extends StatefulWidget {
  MyTextField({
    required this.hint,
    required this.title,
    required this.suffixIcon,
    required this.obscureText,
    required this.inputType,
    required this.takeValue,
    this.action,
    required this.validator,
    required this.controller,
    this.readOnly = false,
    this.paddingHorizontal = AppPadding.p16,
  });

  final String hint;
  final String title;
  final String suffixIcon;
  final bool obscureText;
  final bool readOnly;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final double paddingHorizontal;
  final Function takeValue;
  final Function? action;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  var _isObscured = true;

  @override
  Widget build(BuildContext context) {

    final isArabic = LanguageManager.getCurrentLanguage(context) == ARABIC;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.title.isNotEmpty
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: isArabic ? Alignment.topRight : Alignment.topLeft,
                child: Text(
                  widget.title,
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.size16,
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s10),
            ],
          )
              : const SizedBox(height: AppSize.s1),
          TextFormField(
            obscureText: widget.obscureText ? _isObscured : false,
            keyboardType: widget.inputType,
            textAlign: TextAlign.start,
            controller: widget.controller,
            readOnly: widget.readOnly,
            style: getMediumStyle(
              color: ColorManager.colorBlack_0D,
              fontSize: AppSize.s14,
            ),
            onChanged: (value) {
              widget.takeValue(value);
            },
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: getRegularStyle(
                color: ColorManager.colorGray9C,
                fontSize: AppSize.s14,
              ),
              contentPadding: const EdgeInsets.all(AppPadding.p16),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorManager.colorGrayBc,
                  width: AppSize.s1,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSize.s30),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorManager.colorGrayBc,
                  width: AppSize.s1,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSize.s30),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorManager.colorRedB5,
                  width: AppSize.s2_0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSize.s30),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorManager.colorRedB5, width: AppSize.s2_0),
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s30)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorManager.colorRedB5, width: AppSize.s2_0),
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s30)),
              ),
              suffixIcon: widget.obscureText
                  ? GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: SvgPicture.asset(
                    color: ColorManager.colorGrayBc,
                    _isObscured
                        ? ImageAssets.eyeClosedIcon
                        : ImageAssets.eyeOpenIcon,
                    height: AppSize.s20,
                    width: AppSize.s20,
                  ),
                ),
              )
                  : getSuffixIcon(),
            ),
            onTap: widget.readOnly ? (){
              widget.action!();
            }:null,
          ),
        ],
      ),
    );
  }

  Widget? getSuffixIcon() {
    if (widget.suffixIcon.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: SvgPicture.asset(
          widget.suffixIcon,
          height: AppSize.s20,
          width: AppSize.s20,
        ),
      );
    }
    return null;
  }
}
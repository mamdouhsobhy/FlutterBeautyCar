import 'package:beauty_car/resources/fontManager.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import '../resources/colorManager.dart';
import '../resources/languageManager.dart';
import '../resources/styleManager.dart';
import '../resources/valuesManager.dart';

class MyTextFieldWithPhoneCode extends StatefulWidget {
  final String hint;
  final String title;
  final bool readOnly;
  final bool? hasError;
  final TextEditingController controller;
  final double paddingHorizontal;
  final Function takeValue;
  final Function takeCountryCode;
  final String? Function(String?)? validator;
  const MyTextFieldWithPhoneCode({
    super.key,
    required this.hint,
    required this.title,
    this.readOnly = false,
    this.hasError = false,
    required this.controller,
    this.paddingHorizontal = AppPadding.p16,
    required this.takeValue,
    required this.takeCountryCode,
    this.validator,
  });

  @override
  State<MyTextFieldWithPhoneCode> createState() =>
      _MyTextFieldWithPhoneCodeState();
}

class _MyTextFieldWithPhoneCodeState extends State<MyTextFieldWithPhoneCode> {

  @override
  Widget build(BuildContext context) {

    final isArabic = LanguageManager.getCurrentLanguage(context) == ARABIC;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(alignment: isArabic ? Alignment.topRight : Alignment.topLeft,child: Text(widget.title,style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.size16))),
          const SizedBox(height: AppSize.s10),
          TextFormField(
            controller: widget.controller,
            keyboardType: TextInputType.phone,
            readOnly: widget.readOnly,
            onChanged: (value) {
              widget.takeValue(value);
            },
            validator: widget.validator,
            textAlign: TextAlign.start,
            style: getMediumStyle(
                color: ColorManager.colorBlack_0D,
                fontSize: AppSize.s14
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: getRegularStyle(
                  color: ColorManager.colorGray9C,
                  fontSize: AppSize.s14
              ),
              contentPadding: const EdgeInsets.all(AppPadding.p16),
              border: OutlineInputBorder(
                borderSide:
                BorderSide(color: ColorManager.colorGrayBc, width: AppSize.s1),
                borderRadius: const BorderRadius.all(Radius.circular(AppSize.s30)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorManager.colorGrayBc, width: AppSize.s1),
                borderRadius: const BorderRadius.all(Radius.circular(AppSize.s30)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                BorderSide(color: ColorManager.colorRedB5, width: AppSize.s2_0),
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s30)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorManager.colorRedB5, width: AppSize.s2_0),
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s30)),
              ),
              errorText: widget.hasError == true ? widget.hint : null,
              errorBorder: widget.hasError == true
                  ? const OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorManager.colorRedB5, width: AppSize.s2_0),
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s30)),
              )
                  : null,
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                child: CountryCodePicker(
                  onChanged: (country) {
                    final currentText = widget.controller.text;
                    final newCountryCode = country.dialCode!;

                    final updatedText = currentText.replaceFirst(RegExp(r'^\+\d+'), '');

                    widget.controller.text = newCountryCode + updatedText;
                    widget.takeCountryCode(newCountryCode);
                  },
                  initialSelection: 'EG',
                  // favorite: const ['EG', '+20'],
                  // countryFilter: const ['EG'],
                  showCountryOnly: false,
                  showDropDownButton: false,
                  showOnlyCountryWhenClosed: true,
                  hideMainText: false,
                  alignLeft: false,
                  showFlag: true,
                  flagWidth: 24,
                  builder: (countryCode) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (countryCode?.flagUri != null)
                          Image.asset(
                            countryCode!.flagUri!,
                            package: 'country_code_picker',
                            width: 24,
                            height: 16,
                          ),
                        const SizedBox(width: 4),
                        Text(countryCode!.code!),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_drop_down, size: 20),
                      ],
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

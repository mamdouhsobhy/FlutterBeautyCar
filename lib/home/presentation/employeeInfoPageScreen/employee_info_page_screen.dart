import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../authentication/presentation/sharedViews/auth_title_and_subtitle.dart';
import '../../../resources/assetsManager.dart';
import '../../../resources/stringManager.dart';
import '../../../resources/valuesManager.dart';
import '../../../utils/shared_text_field.dart';
import '../../../utils/shared_text_field_with_phone_code.dart';

class EmployeeInfoPageScreen extends StatefulWidget {
  const EmployeeInfoPageScreen({super.key});

  @override
  State<EmployeeInfoPageScreen> createState() => _EmployeeInfoPageScreenState();
}

class _EmployeeInfoPageScreenState extends State<EmployeeInfoPageScreen> {
  final TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    _userNameController.text = "123Mamdouh456";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.s15),
            MyTextField(
                hint: AppStrings.enterUsername.tr(),
                title: AppStrings.username.tr(),
                suffixIcon: ImageAssets.userIcon,
                obscureText: false,
                readOnly: true,
                inputType: TextInputType.text,
                validator: null,
                controller: _userNameController,
                takeValue: (value) {}
            ),
            const SizedBox(height: AppSize.s16),
            MyTextField(
                hint: AppStrings.enterEmail.tr(),
                title: AppStrings.email.tr(),
                suffixIcon: ImageAssets.emailIcon,
                obscureText: false,
                readOnly: true,
                inputType: TextInputType.emailAddress,
                validator: null,
                controller: _userNameController,
                takeValue: (value) {}
            ),
            const SizedBox(height: AppSize.s16),
            MyTextFieldWithPhoneCode(
                hint: AppStrings.enter_phone_number.tr(),
                title: AppStrings.phone_number.tr(),
                readOnly: true,
                takeValue: (value) {},
                takeCountryCode: (code) {

                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "AppStrings.select_currency.tr()";
                  } else {
                    null;
                  }
                  return null;
                },
                paddingHorizontal: AppPadding.p16,
                controller: _userNameController
            ),
            const SizedBox(height: AppSize.s16),
            MyTextField(
                hint: AppStrings.experience.tr(),
                title: AppStrings.experience.tr(),
                suffixIcon: "",
                readOnly: true,
                obscureText: false,
                inputType: TextInputType.visiblePassword,
                validator: null,
                controller: _userNameController,
                takeValue: (value) {}
            ),
            const SizedBox(height: AppSize.s16),
            MyTextField(
                hint: AppStrings.identity_card_number.tr(),
                title: AppStrings.identity_card_number.tr(),
                suffixIcon: "",
                readOnly: true,
                obscureText: false,
                inputType: TextInputType.visiblePassword,
                validator: null,
                controller: _userNameController,
                takeValue: (value) {}
            ),
            const SizedBox(height: AppSize.s16),
            MyTextField(
                hint: AppStrings.enterStartTime.tr(),
                title: AppStrings.startTime.tr(),
                suffixIcon: "",
                readOnly: true,
                obscureText: false,
                inputType: TextInputType.text,
                validator: null,
                controller: _userNameController,
                takeValue: (value) {}),
            const SizedBox(height: AppSize.s16),
            MyTextField(
                hint: AppStrings.enterEndTime.tr(),
                title: AppStrings.endTime.tr(),
                suffixIcon: "",
                readOnly: true,
                obscureText: false,
                inputType: TextInputType.text,
                validator: null,
                controller: _userNameController,
                takeValue: (value) {}),
            const SizedBox(height: AppSize.s16),
            MyTextField(
                hint: AppStrings.active.tr(),
                title: AppStrings.active.tr(),
                suffixIcon: "",
                readOnly: true,
                obscureText: false,
                inputType: TextInputType.text,
                validator: null,
                controller: _userNameController,
                takeValue: (value) {}),
            const SizedBox(height: AppSize.s30),
          ],
        ));
  }
}

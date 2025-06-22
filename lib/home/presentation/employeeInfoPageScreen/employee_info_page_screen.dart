import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../resources/assetsManager.dart';
import '../../../resources/stringManager.dart';
import '../../../resources/valuesManager.dart';
import '../../../utils/shared_text_field.dart';
import '../../../utils/shared_text_field_with_phone_code.dart';

class EmployeeInfoPageScreen extends StatefulWidget {
  late Data? employee;
  EmployeeInfoPageScreen({super.key,required this.employee});

  @override
  State<EmployeeInfoPageScreen> createState() => _EmployeeInfoPageScreenState();
}

class _EmployeeInfoPageScreenState extends State<EmployeeInfoPageScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _identifyCardNumberController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _activeController = TextEditingController();

  @override
  void initState() {
    _userNameController.text = "${widget.employee?.name}";
    _emailController.text = "${widget.employee?.email}";
    _phoneController.text = "${widget.employee?.phone}";
    _experienceController.text = "${widget.employee?.experiance}";
    _identifyCardNumberController.text = "${widget.employee?.ssdNum}";
    _startTimeController.text = "${widget.employee?.startTime}";
    _endTimeController.text = "${widget.employee?.endTime}";
    _activeController.text = widget.employee?.status == 1 ? AppStrings.un_active.tr() : AppStrings.active.tr();
    setState(() {
    });
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
                controller: _emailController,
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
                paddingHorizontal: AppPadding.p16,
                controller: _phoneController
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
                controller: _experienceController,
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
                controller: _identifyCardNumberController,
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
                controller: _startTimeController,
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
                controller: _endTimeController,
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
                controller: _activeController,
                takeValue: (value) {}),
            const SizedBox(height: AppSize.s30),
          ],
        ));
  }
}

import 'package:beauty_car/home/presentation/homeSharedViews/center_service_selected_item.dart';
import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/colorManager.dart';
import '../../../resources/fontManager.dart';
import '../../../resources/styleManager.dart';
import '../../../resources/valuesManager.dart';
import '../../../utils/shared_appbar.dart';
import '../../../utils/shared_button.dart';
import '../../../utils/shared_text_field.dart';
import '../../../utils/shared_text_field_with_phone_code.dart';

class CreateCenterScreen extends StatefulWidget {
  const CreateCenterScreen({super.key});

  @override
  State<CreateCenterScreen> createState() => _CreateCenterScreenState();
}

class _CreateCenterScreenState extends State<CreateCenterScreen> {
  final _formKey = GlobalKey<FormState>();

  String _selectedStatus = "open";
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: ColorManager.white,
          appBar: MyAppBar(title: AppStrings.createCenter.tr()),
          body: SafeArea(
              child:
                  // StreamBuilder<FlowState>(
                  //   stream: _loginViewModel.outputState,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.data != null) {
                  //       _handleLoginStateChanged(snapshot.data!);
                  //     }
                  _getCreateCentersScreenContent()
              // },
              // ),
              ),
        ));
  }

  Widget _getCreateCentersScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: AppSize.s30),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                        width: AppSize.s80,
                        height: AppSize.s80,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: SvgPicture.asset(ImageAssets.avatarIcon,
                            fit: BoxFit.cover)),
                    GestureDetector(
                      onTap: () {
                        // Handle image edit action
                      },
                      child: Container(
                        width: AppSize.s30,
                        height: AppSize.s30,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Icon(Icons.camera_alt,
                            size: AppSize.s18, color: ColorManager.colorRedB2),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                autovalidateMode: AutovalidateMode.onUnfocus,
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyTextField(
                        hint: AppStrings.enterCenterName.tr(),
                        title: AppStrings.centerName.tr(),
                        suffixIcon: "",
                        obscureText: false,
                        inputType: TextInputType.text,
                        validator: null,
                        controller: _searchController,
                        takeValue: (value) {}),
                    const SizedBox(height: AppSize.s16),
                    MyTextField(
                        hint: AppStrings.enterAddress.tr(),
                        title: AppStrings.address.tr(),
                        suffixIcon: "",
                        obscureText: false,
                        inputType: TextInputType.text,
                        validator: null,
                        controller: _searchController,
                        takeValue: (value) {}),
                    const SizedBox(height: AppSize.s16),
                    MyTextFieldWithPhoneCode(
                        hint: AppStrings.enter_phone_number.tr(),
                        title: AppStrings.phone_number.tr(),
                        readOnly: false,
                        takeValue: (value) {},
                        takeCountryCode: (code) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "AppStrings.select_currency.tr()";
                          } else {
                            null;
                          }
                          return null;
                        },
                        paddingHorizontal: AppPadding.p16,
                        controller: _searchController),
                    const SizedBox(height: AppSize.s16),
                    MyTextField(
                        hint: AppStrings.selectServices.tr(),
                        title: AppStrings.services.tr(),
                        suffixIcon: ImageAssets.arrowDownIcon,
                        readOnly: true,
                        obscureText: false,
                        inputType: TextInputType.text,
                        validator: null,
                        controller: _searchController,
                        takeValue: (value) {},
                        action: (){
                          _openBottomSheetLookUpList(context);
                        },
                    ),
                    const SizedBox(height: AppSize.s16),
                    MyTextField(
                        hint: AppStrings.enterEmployeeName.tr(),
                        title: AppStrings.employeeName.tr(),
                        suffixIcon: ImageAssets.arrowDownIcon,
                        readOnly: true,
                        obscureText: false,
                        inputType: TextInputType.text,
                        validator: null,
                        controller: _searchController,
                        takeValue: (value) {}),
                    const SizedBox(height: AppSize.s16),
                    MyTextField(
                        hint: AppStrings.enterStartTime.tr(),
                        title: AppStrings.startTime.tr(),
                        suffixIcon: ImageAssets.arrowDownIcon,
                        readOnly: true,
                        obscureText: false,
                        inputType: TextInputType.text,
                        validator: null,
                        controller: _searchController,
                        takeValue: (value) {}),
                    const SizedBox(height: AppSize.s16),
                    MyTextField(
                        hint: AppStrings.enterEndTime.tr(),
                        title: AppStrings.endTime.tr(),
                        suffixIcon: ImageAssets.arrowDownIcon,
                        readOnly: true,
                        obscureText: false,
                        inputType: TextInputType.text,
                        validator: null,
                        controller: _searchController,
                        takeValue: (value) {}),
                    const SizedBox(height: AppSize.s16),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                        child: Text(AppStrings.status.tr(),
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.size16,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: AppPadding.p40),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: "open",
                                activeColor: ColorManager.colorRedB2,
                                groupValue: _selectedStatus,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedStatus = value.toString();
                                  });
                                },
                              ),
                              Text(
                                AppStrings.open.tr(),
                                style: getRegularStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.size16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: "closed",
                                activeColor: ColorManager.colorRedB2,
                                groupValue: _selectedStatus,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedStatus = value.toString();
                                  });
                                },
                              ),
                              Text(
                                AppStrings.closed.tr(),
                                style: getRegularStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.size16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              )
            ],
          ),
        )),
        const SizedBox(height: AppSize.s20),
        MyButton(
          color: ColorManager.colorRedB2,
          buttonText: AppStrings.save.tr(),
          paddingVertical: AppPadding.p0,
          fun: () {
            Navigator.pop(context);
            // if (_formKey.currentState?.validate() ?? false) {
            //   if (!_isTermsAccepted) {
            //     //context.showErrorToast(AppStrings.please_accept_terms.tr());
            //     return;
            //   }
            //   // Handle login
            // }
          },
        ),
        const SizedBox(height: AppSize.s20),
      ],
    );
  }

  void _openBottomSheetLookUpList(BuildContext context) {

    List<String> services = [
      "مغاسل السيارات","وكلات السيارات","خدمات التقدير والحمايه ","خدمات الاطارات"
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (ctx) {
          return CenterServiceSelectedItem("title", services, selectedService: (value){
            Navigator.of(context).pop();
          });
        },
      );
    });
  }

}

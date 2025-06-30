import 'package:beauty_car/resources/stringManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/di/di.dart';
import '../../../app/state_renderer/state_renderer_impl.dart';
import '../../../resources/assetsManager.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/valuesManager.dart';
import '../../../utils/function.dart';
import '../../../utils/loading_page.dart';
import '../../../utils/shared_appbar.dart';
import '../../../utils/shared_button.dart';
import '../../../utils/shared_text_field.dart';
import '../../../utils/shared_text_field_with_phone_code.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker _imagePicker = instance<ImagePicker>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: ColorManager.white,
          appBar: MyAppBar(title: AppStrings.edit_profile.tr()),
          body: SafeArea(
              child:
                  // StreamBuilder<FlowState>(
                  //   stream: _createEmployeeViewModel.outputState,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.data != null && _createEmployeeViewModel.isOutStateLoading) {
                  //       _handleCreateOrUpdateStateChanged(snapshot.data!);
                  //     }
                  _getEditProfileScreenContent()
              // },
              // ),
              ),
        ));
  }

  Widget _getEditProfileScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: AppSize.s30),
                Column(
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                              width: AppSize.s80,
                              height: AppSize.s80,
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              child: SvgPicture.asset(ImageAssets.avatarIcon)),
                          GestureDetector(
                            onTap: () {
                              _showImagePicker(context);
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyTextField(
                              hint: AppStrings.enterUsername.tr(),
                              title: AppStrings.username.tr(),
                              suffixIcon: ImageAssets.userIcon,
                              obscureText: false,
                              inputType: TextInputType.text,
                              controller: _userNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings.enterUsername.tr();
                                } else {
                                  null;
                                }
                                return null;
                              },
                              takeValue: (value) {
                                _userNameController.text = value;
                                // _createEmployeeViewModel.createOrUpdateEmployee.name = value;
                              }),
                          const SizedBox(height: AppSize.s16),
                          MyTextField(
                              hint: AppStrings.enterEmail.tr(),
                              title: AppStrings.email.tr(),
                              suffixIcon: ImageAssets.emailIcon,
                              obscureText: false,
                              inputType: TextInputType.emailAddress,
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings.enterEmail.tr();
                                } else if (!isEmailValid(value)) {
                                  return AppStrings.enter_valid_email.tr();
                                } else {
                                  null;
                                }
                                return null;
                              },
                              takeValue: (value) {
                                _emailController.text = value;
                                // _createEmployeeViewModel.createOrUpdateEmployee.email = value;
                              }),
                          const SizedBox(height: AppSize.s16),
                          MyTextFieldWithPhoneCode(
                              hint: AppStrings.enter_phone_number.tr(),
                              title: AppStrings.phone_number.tr(),
                              readOnly: false,
                              defaultCountryCode:
                              getIsoCode(_countryCodeController.text) ?? "SA",
                              takeValue: (value) {
                                _phoneController.text = value;
                                // _createEmployeeViewModel.createOrUpdateEmployee.phone = "";
                                // _createEmployeeViewModel.createOrUpdateEmployee.phone = _countryCodeController.text + value;
                              },
                              takeCountryCode: (code) {
                                _countryCodeController.text = code;
                                // _createEmployeeViewModel.createOrUpdateEmployee.phone = "";
                                // _createEmployeeViewModel.createOrUpdateEmployee.phone = code + _phoneController.text;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings.enter_phone_number.tr();
                                } else if (!isPhoneValid(_phoneController.text,
                                    _countryCodeController.text)) {
                                  return AppStrings.enter_valid_phone.tr();
                                }
                                return null;
                              },
                              paddingHorizontal: AppPadding.p16,
                              controller: _phoneController
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSize.s16),
        MyButton(
          color: ColorManager.colorRedB2,
          buttonText: AppStrings.save.tr(),
          paddingVertical: AppPadding.p0,
          fun: () {
            if (_formKey.currentState?.validate() ?? false) {
              // if (_employeeId == null && _createEmployeeViewModel.createOrUpdateEmployee.image == null) {
              //   context.showErrorToast(AppStrings.select_employee_image.tr());
              //   return;
              // }

              // if (_employeeId == null) {
              //   _createEmployeeViewModel.createEmployee();
              // } else {
              //   _createEmployeeViewModel.updateEmployee();
              // }
            }
          },
        ),
        const SizedBox(height: AppSize.s16)
      ],
    );
  }

  _showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.arrow_forward),
                trailing: Icon(Icons.camera),
                title: Text(AppStrings.photo_From_Gallery.tr()),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.arrow_forward),
                trailing: Icon(Icons.camera_alt_outlined),
                title: Text(AppStrings.photo_From_Camera.tr()),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        });
  }

  _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // _createEmployeeViewModel.createOrUpdateEmployee.image = File(image.path ?? "");
      setState(() {});
    }
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // _createEmployeeViewModel.createOrUpdateEmployee.image = File(image.path ?? "");
      setState(() {});
    }
  }

  _handleEditProfileStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        // _createEmployeeViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        // _createEmployeeViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _countryCodeController.dispose();
    // _createEmployeeViewModel.dispose();
    super.dispose();
  }
}

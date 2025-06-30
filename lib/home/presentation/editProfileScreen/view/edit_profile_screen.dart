import 'dart:io';

import 'package:beauty_car/home/presentation/editProfileScreen/viewmodel/profile_viewmodel.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/di/di.dart';
import '../../../../app/sharedPrefs/app_prefs.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../authentication/data/response/login/login.dart';
import '../../../../resources/assetsManager.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../../utils/function.dart';
import '../../../../utils/loading_page.dart';
import '../../../../utils/shared_appbar.dart';
import '../../../../utils/shared_button.dart';
import '../../../../utils/shared_text_field.dart';
import '../../../../utils/shared_text_field_with_phone_code.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final ProfileViewModel _profileViewModel = instance<ProfileViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  ModelLoginResponseRemote? userData;

  final ImagePicker _imagePicker = instance<ImagePicker>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  XFile? userImage;

  _bind(){
    _profileViewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if(userData == null) {
      userData = await _appPreferences.getUserData();
      fillUserDate();
    }
    super.didChangeDependencies();
  }

  fillUserDate(){
    _userNameController.text = "${userData?.data?.name}";
    _emailController.text = "${userData?.data?.email}";
    _countryCodeController.text = getCountryCode("${userData?.data?.phone}")!;
    _phoneController.text = "${userData?.data?.phone}".replaceAll(_countryCodeController.text, "");
    setState(() {});
  }

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
              child: StreamBuilder<FlowState>(
                    stream: _profileViewModel.outputState,
                    builder: (context, snapshot) {
                      if (snapshot.data != null && _profileViewModel.isOutStateLoading) {
                        _handleEditProfileStateChanged(snapshot.data!);
                      }
                 return _getEditProfileScreenContent();
              },
              ),
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
                              child: getUserImage()) ,
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
                              }),
                          const SizedBox(height: AppSize.s16),
                          MyTextField(
                              hint: AppStrings.enterEmail.tr(),
                              title: AppStrings.email.tr(),
                              suffixIcon: ImageAssets.emailIcon,
                              obscureText: false,
                              readOnly: true,
                              inputType: TextInputType.emailAddress,
                              controller: _emailController,
                              validator: null,
                              takeValue: (value) {
                                _emailController.text = value;
                                // _createEmployeeViewModel.createOrUpdateEmployee.email = value;
                              }),
                          const SizedBox(height: AppSize.s16),
                          MyTextFieldWithPhoneCode(
                              hint: AppStrings.enter_phone_number.tr(),
                              title: AppStrings.phone_number.tr(),
                              readOnly: true,
                              defaultCountryCode: getIsoCode(_countryCodeController.text) ?? "SA",
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
                              validator: null,
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
        StreamBuilder<ModelLoginResponseRemote>(
            stream: _profileViewModel.outputUpdateProfileData,
            builder: (ctx, snapshot) {
              if (snapshot.data != null && snapshot.data?.status == true) {
                if(_profileViewModel.isUpdateLoading){
                  _profileViewModel.isUpdateLoading = false;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  userData?.data?.image = snapshot.data?.data?.image;
                  userData?.data?.name = snapshot.data?.data?.name;
                  _appPreferences.setUserData(userData!);
                  _navigateToSettingScreen();
                });
                }
              }
              return MyButton(
                color: ColorManager.colorRedB2,
                buttonText: AppStrings.save.tr(),
                paddingVertical: AppPadding.p0,
                fun: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _profileViewModel.updateProfile(
                        _userNameController.text, userImage != null ? File(userImage!.path) : null);
                  }
                },
              );
            }),
        const SizedBox(height: AppSize.s16)
      ],
    );
  }

  _navigateToSettingScreen(){
    context.showSuccessToast(AppStrings.profile_update_successully.tr());
    Navigator.pop(context);
  }

  Widget getUserImage(){
    if(userImage == null && userData?.data?.image == null){
      return SvgPicture.asset(ImageAssets.avatarIcon);
    }else if(userImage != null){
     return ClipOval(
        child: Image.file(File(userImage!.path),fit: BoxFit.cover),
      );
    }else{
      return ClipOval(
        child: Image.network("${userData?.data?.image}",fit: BoxFit.cover),
      );
    }
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
      userImage = image;
      setState(() {});
    }
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      userImage = image;
      setState(() {});
    }
  }

  _handleEditProfileStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _profileViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _profileViewModel.isOutStateLoading = false;
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
    _profileViewModel.dispose();
    super.dispose();
  }
}

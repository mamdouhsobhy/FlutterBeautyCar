import 'dart:io';

import 'package:beauty_car/home/data/response/createOrUpdateEmployee/create_or_update_employee.dart';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/presentation/createEmployeeScreen/viewmodel/create_employee_viewmodel.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../resources/assetsManager.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/fontManager.dart';
import '../../../../resources/stringManager.dart';
import '../../../../resources/styleManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../../utils/Constants.dart';
import '../../../../utils/function.dart';
import '../../../../utils/loading_page.dart';
import '../../../../utils/shared_appbar.dart';
import '../../../../utils/shared_button.dart';
import '../../../../utils/shared_text_field.dart';
import '../../../../utils/shared_text_field_with_phone_code.dart';

class CreateEmployeeScreen extends StatefulWidget {
  const CreateEmployeeScreen({super.key});

  @override
  State<CreateEmployeeScreen> createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {

  final CreateEmployeeViewModel _createEmployeeViewModel = instance<CreateEmployeeViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _identifyCardNumController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  String _selectedStatus = AppStrings.active.tr();

  final _formKey = GlobalKey<FormState>();

  TimeOfDay time = TimeOfDay(hour: 07,minute: 50);

  String? _employeeId;

  _bind() {
    _createEmployeeViewModel.start();
    _createEmployeeViewModel.createOrUpdateEmployee.status = CenterStatus.open;
    _countryCodeController.text = Constants.defaultCountryCode;
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      _employeeId = args['employeeId']?.toString().isEmpty == true ? null : args['employeeId'];
      if (_employeeId != null && _createEmployeeViewModel.isEmployeeFirstLoad == false) {
        _createEmployeeViewModel.isEmployeeFirstLoad = true;
        _createEmployeeViewModel.createOrUpdateEmployee.employeeId = _employeeId!;
        _createEmployeeViewModel.getEmployeeDetails("$_employeeId");
      }
    } else {
      debugPrint("Arguments are not a Map<String, dynamic>");
    }
  }

  _setEmployeeData(AsyncSnapshot<ModelEmployeesResponseRemote> snapshot){
    final employee = snapshot.data?.data![0];
    _userNameController.text = "${employee?.name}";
    _createEmployeeViewModel.createOrUpdateEmployee.name = "${employee?.name}";

    _emailController.text = "${employee?.email}";
    _createEmployeeViewModel.createOrUpdateEmployee.email = "${employee?.email}";

    _countryCodeController.text = getCountryCode("${employee?.phone}")!;
    _phoneController.text = employee!.phone!.replaceAll(_countryCodeController.text, "");
    _createEmployeeViewModel.createOrUpdateEmployee.phone = _countryCodeController.text + _phoneController.text;

    _experienceController.text = "${employee?.experiance}";
    _createEmployeeViewModel.createOrUpdateEmployee.experiance = "${employee?.experiance}";

    _identifyCardNumController.text = "${employee?.ssdNum}";
    _createEmployeeViewModel.createOrUpdateEmployee.ssd_num = "${employee?.ssdNum}";

    _startTimeController.text = "${employee?.startTime}";
    _createEmployeeViewModel.createOrUpdateEmployee.start_time = "${employee?.startTime}";

    _endTimeController.text = "${employee?.endTime}";
    _createEmployeeViewModel.createOrUpdateEmployee.end_time = "${employee?.endTime}";

    if(employee?.status.toString() == CenterStatus.open){
      _selectedStatus = AppStrings.active.tr();
      _createEmployeeViewModel.createOrUpdateEmployee.status = CenterStatus.open;
      setState(() {});
    }else{
      _selectedStatus = AppStrings.un_active.tr();
      _createEmployeeViewModel.createOrUpdateEmployee.status = CenterStatus.closed;
      setState(() {});
    }

    print("Counter +1");

  }

  _navigateToHome(){
    if (_employeeId == null) {
      context.showSuccessToast(
          AppStrings.employee_created_successfully.tr());
    }else{
      context.showSuccessToast(
          AppStrings.employee_updated_successfully.tr());
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      if (context.mounted && Navigator.canPop(context)) {
        Navigator.pop(context, true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: ColorManager.white,
          appBar: MyAppBar(title: _employeeId == null ? AppStrings.create_employee.tr() : AppStrings.update_employee.tr()),
          body: SafeArea(
            child: StreamBuilder<FlowState>(
              stream: _createEmployeeViewModel.outputState,
              builder: (context, snapshot) {
                if (snapshot.data != null && _createEmployeeViewModel.isOutStateLoading) {
                  _handleCreateOrUpdateStateChanged(snapshot.data!);
                }
                return _getCreateEmployeeScreenContent();
              },
            ),
          ),
    ));
  }

  Widget _getCreateEmployeeScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: AppSize.s30),
        Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder<ModelEmployeesResponseRemote>(
                  stream: _createEmployeeViewModel.outputEmployeesData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data?.data?.isNotEmpty == true) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if(_createEmployeeViewModel.isEmployeeLoading) {
                          _createEmployeeViewModel.isEmployeeLoading = false;
                          _setEmployeeData(snapshot);
                        }
                      });
                    }
                    return Column(
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                  width: AppSize.s80,
                                  height: AppSize.s80,
                                  decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                                  child: _createEmployeeViewModel
                                      .createOrUpdateEmployee.image ==
                                      null
                                      ? _employeeId != null ? ClipOval(child: Image.network("${snapshot.data?.data![0].image}",fit: BoxFit.cover)) : SvgPicture.asset(ImageAssets.avatarIcon,
                                      fit: BoxFit.cover)
                                      : ClipOval(
                                        child: Image.file(_createEmployeeViewModel
                                        .createOrUpdateEmployee.image!,fit: BoxFit.cover),
                                      )),
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
                                      size: AppSize.s18,
                                      color: ColorManager.colorRedB2),
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
                                      hint: AppStrings.enterUsername.tr(),
                                      title: AppStrings.username.tr(),
                                      suffixIcon: ImageAssets.userIcon,
                                      obscureText: false,
                                      inputType: TextInputType.text,
                                      controller: _userNameController,
                                      validator: (value){
                                        if (value == null || value.isEmpty) {
                                          return AppStrings.enterUsername.tr();
                                        } else {
                                          null;
                                        }
                                        return null;
                                      },
                                      takeValue: (value) {
                                        _userNameController.text = value;
                                        _createEmployeeViewModel.createOrUpdateEmployee.name = value;
                                      }
                                  ),
                                  const SizedBox(height: AppSize.s16),
                                  MyTextField(
                                      hint: AppStrings.enterEmail.tr(),
                                      title: AppStrings.email.tr(),
                                      suffixIcon: ImageAssets.emailIcon,
                                      obscureText: false,
                                      inputType: TextInputType.emailAddress,
                                      controller: _emailController,
                                      validator: (value){
                                        if (value == null || value.isEmpty) {
                                          return AppStrings.enterEmail.tr();
                                        }else if(!isEmailValid(value)){
                                          return AppStrings.enter_valid_email.tr();
                                        } else {
                                          null;
                                        }
                                        return null;
                                      },
                                      takeValue: (value) {
                                        _emailController.text = value;
                                        _createEmployeeViewModel.createOrUpdateEmployee.email = value;
                                      }
                                  ),
                                  const SizedBox(height: AppSize.s16),
                                  MyTextFieldWithPhoneCode(
                                      hint: AppStrings.enter_phone_number.tr(),
                                      title: AppStrings.phone_number.tr(),
                                      readOnly: false,
                                      defaultCountryCode: getIsoCode(_countryCodeController.text) ?? "SA",
                                      takeValue: (value) {
                                        _phoneController.text = value;
                                        _createEmployeeViewModel.createOrUpdateEmployee.phone = "";
                                        _createEmployeeViewModel.createOrUpdateEmployee.phone = _countryCodeController.text + value;
                                      },
                                      takeCountryCode: (code) {
                                        _countryCodeController.text = code;
                                        _createEmployeeViewModel.createOrUpdateEmployee.phone = "";
                                        _createEmployeeViewModel.createOrUpdateEmployee.phone = code + _phoneController.text;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppStrings.enter_phone_number.tr();
                                        } else if (!isPhoneValid(_phoneController.text, _countryCodeController.text)) {
                                          return AppStrings.enter_valid_phone.tr();
                                        }
                                        return null;
                                      },
                                      paddingHorizontal: AppPadding.p16,
                                      controller: _phoneController),
                                  const SizedBox(height: AppSize.s16),
                                  MyTextField(
                                      hint: AppStrings.enterPassword.tr(),
                                      title: AppStrings.password.tr(),
                                      suffixIcon: "",
                                      obscureText: true,
                                      inputType: TextInputType.visiblePassword,
                                      controller: _passwordController,
                                      validator: (value){
                                        if (value == null || value.isEmpty) {
                                          return AppStrings.enterPassword.tr();
                                        } else if(_passwordController.text.length < 6){
                                          return AppStrings.password_must_be_6_character.tr();
                                        } else {
                                          null;
                                        }
                                        return null;
                                      },
                                      takeValue: (value) {
                                        _passwordController.text = value;
                                        _createEmployeeViewModel.createOrUpdateEmployee.password = value;
                                      }
                                  ),
                                  const SizedBox(height: AppSize.s16),
                                  MyTextField(
                                      hint: AppStrings.enterPassword.tr(),
                                      title: AppStrings.confirmPassword.tr(),
                                      suffixIcon: "",
                                      obscureText: true,
                                      inputType: TextInputType.visiblePassword,
                                      controller: _confirmPasswordController,
                                      validator: (value){
                                        if (value == null || value.isEmpty) {
                                          return AppStrings.confirmPassword.tr();
                                        }else if(_confirmPasswordController.text.length < 6){
                                          return AppStrings.password_must_be_6_character.tr();
                                        }else if(_confirmPasswordController.text != _passwordController.text){
                                          return AppStrings.confirm_password_must_at_the_same_password.tr();
                                        } else {
                                          null;
                                        }
                                        return null;
                                      },
                                      takeValue: (value) {
                                        _confirmPasswordController.text = value;
                                        _createEmployeeViewModel.createOrUpdateEmployee.password_confirmation = value;
                                      }
                                  ),
                                  const SizedBox(height: AppSize.s16),
                                  MyTextField(
                                      hint: AppStrings.experience.tr(),
                                      title: AppStrings.experience.tr(),
                                      suffixIcon: "",
                                      obscureText: false,
                                      inputType: TextInputType.number,
                                      controller: _experienceController,
                                      validator: (value){
                                        if (value == null || value.isEmpty) {
                                          return AppStrings.experience.tr();
                                        } else {
                                          null;
                                        }
                                        return null;
                                      },
                                      takeValue: (value) {
                                        _experienceController.text = value;
                                        _createEmployeeViewModel.createOrUpdateEmployee.experiance = value;
                                      }
                                  ),
                                  const SizedBox(height: AppSize.s16),
                                  MyTextField(
                                      hint: AppStrings.identity_card_number.tr(),
                                      title: AppStrings.identity_card_number.tr(),
                                      suffixIcon: "",
                                      obscureText: false,
                                      inputType: TextInputType.number,
                                      controller: _identifyCardNumController,
                                      validator: (value){
                                        if (value == null || value.isEmpty) {
                                          return AppStrings.identity_card_number.tr();
                                        } else {
                                          null;
                                        }
                                        return null;
                                      },
                                      takeValue: (value) {
                                        _identifyCardNumController.text = value;
                                        _createEmployeeViewModel.createOrUpdateEmployee.ssd_num = value;
                                      }
                                  ),
                                  const SizedBox(height: AppSize.s16),
                                  MyTextField(
                                      hint: AppStrings.enterStartTime.tr(),
                                      title: AppStrings.startTime.tr(),
                                      suffixIcon: ImageAssets.arrowDownIcon,
                                      readOnly: true,
                                      obscureText: false,
                                      inputType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppStrings.enterStartTime.tr();
                                        } else {
                                          null;
                                        }
                                        return null;
                                      },
                                      controller: _startTimeController,
                                      takeValue: (value) {},
                                      action: () async {
                                        TimeOfDay? newTime = await showTimePicker(
                                            context: context, initialTime: time);

                                        if (newTime != null) {
                                          _startTimeController.text =
                                          "${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}:00";
                                          _createEmployeeViewModel.createOrUpdateEmployee.start_time = _startTimeController.text;
                                        }
                                      }),
                                  const SizedBox(height: AppSize.s16),
                                  MyTextField(
                                      hint: AppStrings.enterEndTime.tr(),
                                      title: AppStrings.endTime.tr(),
                                      suffixIcon: ImageAssets.arrowDownIcon,
                                      readOnly: true,
                                      obscureText: false,
                                      inputType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppStrings.enterEndTime.tr();
                                        } else {
                                          null;
                                        }
                                        return null;
                                      },
                                      controller: _endTimeController,
                                      takeValue: (value) {},
                                      action: () async {
                                        TimeOfDay? newTime = await showTimePicker(
                                            context: context, initialTime: time);

                                        if (newTime != null) {
                                          _endTimeController.text =
                                          "${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}:00";
                                          _createEmployeeViewModel.createOrUpdateEmployee.end_time = _endTimeController.text;
                                        }
                                      }),
                                  const SizedBox(height: AppSize.s16),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppPadding.p16),
                                      child: Text(AppStrings.status.tr(),
                                          style: getBoldStyle(
                                            color: ColorManager.black,
                                            fontSize: FontSize.size16,
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: AppPadding.p40, left: AppPadding.p20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Radio(
                                              value: AppStrings.active.tr(),
                                              activeColor: ColorManager.colorRedB2,
                                              groupValue: _selectedStatus,
                                              onChanged: (value) {
                                                setState(() {
                                                  _createEmployeeViewModel.createOrUpdateEmployee.status = CenterStatus.open;
                                                  _selectedStatus = value.toString();
                                                });
                                              },
                                            ),
                                            Text(
                                              AppStrings.active.tr(),
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
                                              value: AppStrings.un_active.tr(),
                                              activeColor: ColorManager.colorRedB2,
                                              groupValue: _selectedStatus,
                                              onChanged: (value) {
                                                setState(() {
                                                  _createEmployeeViewModel.createOrUpdateEmployee.status = CenterStatus.closed;
                                                  _selectedStatus = value.toString();
                                                });
                                              },
                                            ),
                                            Text(
                                              AppStrings.un_active.tr(),
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
                    );
                  }),
            )),
        const SizedBox(height: AppSize.s20),
        StreamBuilder<ModelCreateOrUpdateEmployeeResponseRemote>(
          stream: _createEmployeeViewModel.outputCreateOrUpdateEmployeeData,
          builder: (ctx, snapshot) {
            if (snapshot.data != null && snapshot.data?.status == true) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                 _navigateToHome();
              });
            }
            return MyButton(
              color: ColorManager.colorRedB2,
              buttonText: AppStrings.save.tr(),
              paddingVertical: AppPadding.p0,
              fun: () {
                if (_formKey.currentState?.validate() ?? false) {
                  if (_employeeId == null && _createEmployeeViewModel.createOrUpdateEmployee.image == null) {
                    context.showErrorToast(AppStrings.select_employee_image.tr());
                    return;
                  }

                  if (_employeeId == null) {
                    _createEmployeeViewModel.createEmployee();
                  } else {
                    _createEmployeeViewModel.updateEmployee();
                  }
                }
              },
            );
          },
        ),
        const SizedBox(height: AppSize.s20),
      ],
    );
  }

  _showImagePicker(BuildContext context){
    showModalBottomSheet(context: context, builder: (BuildContext ctx){
      return SafeArea(child:
      Wrap(children: [
        ListTile(
          leading: Icon(Icons.arrow_forward),
          trailing: Icon(Icons.camera),
          title: Text(AppStrings.photo_From_Gallery.tr()),
          onTap: (){
            _imageFromGallery();
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: Icon(Icons.arrow_forward),
          trailing: Icon(Icons.camera_alt_outlined),
          title: Text(AppStrings.photo_From_Camera.tr()),
          onTap: (){
            _imageFromCamera();
            Navigator.of(context).pop();
          },
        )
      ],
      ));
    });
  }

  _imageFromGallery() async{
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null) {
      _createEmployeeViewModel.createOrUpdateEmployee.image = File(image.path ?? "");
      setState(() {});
    }
  }

  _imageFromCamera() async{
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    if(image!=null) {
      _createEmployeeViewModel.createOrUpdateEmployee.image = File(image.path ?? "");
      setState(() {});
    }
  }

  _handleCreateOrUpdateStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _createEmployeeViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _createEmployeeViewModel.isOutStateLoading = false;
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
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _experienceController.dispose();
    _identifyCardNumController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _createEmployeeViewModel.dispose();
    super.dispose();
  }

}

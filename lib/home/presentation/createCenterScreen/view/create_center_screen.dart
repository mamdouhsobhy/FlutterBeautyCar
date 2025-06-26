import 'dart:io';

import 'package:beauty_car/home/data/response/centers/centers.dart';
import 'package:beauty_car/home/data/response/createOrUpdateCenter/create_or_update_center.dart';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/data/response/services/services.dart';
import 'package:beauty_car/home/presentation/createCenterScreen/viewmodel/create_center_viewmodel.dart';
import 'package:beauty_car/home/presentation/homeSharedViews/center_employee_selected_item.dart';
import 'package:beauty_car/home/presentation/homeSharedViews/center_service_selected_item.dart';
import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/fontManager.dart';
import '../../../../resources/styleManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../../utils/Constants.dart';
import '../../../../utils/function.dart';
import '../../../../utils/loading_page.dart';
import '../../../../utils/shared_appbar.dart';
import '../../../../utils/shared_button.dart';
import '../../../../utils/shared_text_field.dart';
import '../../../../utils/shared_text_field_with_phone_code.dart';

class CreateCenterScreen extends StatefulWidget {
  const CreateCenterScreen({super.key});

  @override
  State<CreateCenterScreen> createState() => _CreateCenterScreenState();
}

class _CreateCenterScreenState extends State<CreateCenterScreen> {

  final CreateCenterViewModel _createCenterViewModel = instance<CreateCenterViewModel>();
  ModelServicesResponseRemote? services;
  ModelEmployeesResponseRemote? employees;
  final ImagePicker _imagePicker = instance<ImagePicker>();

  final TextEditingController _centerNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final TextEditingController _servicesController = TextEditingController();
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  String _selectedStatus = AppStrings.open.tr();

  final _formKey = GlobalKey<FormState>();

  TimeOfDay time = TimeOfDay(hour: 07,minute: 50);

  String? _centerId;

  _bind() {
    _createCenterViewModel.start();
    _createCenterViewModel.createOrUpdateCenter.status = CenterStatus.open;
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
      _centerId = args['centerId']?.toString().isEmpty == true ? null : args['centerId'];
      if (_centerId != null && _createCenterViewModel.isCenterFirstLoad == false) {
        _createCenterViewModel.isCenterFirstLoad = true;
        _createCenterViewModel.createOrUpdateCenter.centerId = _centerId!;
        _createCenterViewModel.getCenterDetails();
      }
    } else {
      debugPrint("Arguments are not a Map<String, dynamic>");
    }
  }

  _setCenterData(AsyncSnapshot<ModelCentersResponseRemote> snapshot){
    final center = snapshot.data?.data![0];
    _centerNameController.text = "${center?.name}";
    _createCenterViewModel.createOrUpdateCenter.centerName = "${center?.name}";

    _addressController.text = "${center?.address}";
    _createCenterViewModel.createOrUpdateCenter.address = "${center?.address}";

    _countryCodeController.text = getCountryCode("${center?.phone}")!;
    _phoneController.text = center!.phone!.replaceAll(_countryCodeController.text, "");
    _createCenterViewModel.createOrUpdateCenter.phone = _countryCodeController.text + _phoneController.text;

    if (center != null && center.serviceIds?.isNotEmpty == true) {
      if (services?.data?.isNotEmpty == true) {
        services!.data!.forEach((item) {
          if (center.serviceIds!.contains(item.id.toString())) {
            item.selected = true;
          }
        });
        final selectedServices = services!.data!
            .where((item) => center.serviceIds!.contains(item.id.toString()))
            .toList();
        _servicesController.text =
            selectedServices.map((service) => service.name).join(' , ');
      }
    }

    if(center!=null && center.serviceIds?.isNotEmpty == true) {
      for (String service in center.serviceIds!) {
        _createCenterViewModel.services.add(
            Services(id: int.parse(service), name: "", image: ""));
      }
    }

    _employeeNameController.text = "${center?.employee?.name}";
    _createCenterViewModel.createOrUpdateCenter.employeeId = "${center?.employee?.id}";

    _startTimeController.text = "${center?.openTime}";
    _createCenterViewModel.createOrUpdateCenter.openTime = "${center?.openTime}";

    _endTimeController.text = "${center?.closeTime}";
    _createCenterViewModel.createOrUpdateCenter.closedTime = "${center?.closeTime}";

    if(center?.status.toString() == CenterStatus.open){
      _selectedStatus = AppStrings.open.tr();
      _createCenterViewModel.createOrUpdateCenter.status = CenterStatus.open;
      setState(() {});
    }else{
      _selectedStatus = AppStrings.closed.tr();
      _createCenterViewModel.createOrUpdateCenter.status = CenterStatus.closed;
      setState(() {});
    }

    print("Counter +1");

  }

  _navigateToHome(){
    if (_centerId == null) {
      context.showSuccessToast(
          AppStrings.center_created_successfully.tr());
    }else{
      context.showSuccessToast(
          AppStrings.center_updated_successfully.tr());
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
          appBar: MyAppBar(title: _centerId == null ? AppStrings.createCenter.tr() : AppStrings.update_center.tr()),
          body: SafeArea(
            child: StreamBuilder<FlowState>(
              stream: _createCenterViewModel.outputState,
              builder: (context, snapshot) {
                if (snapshot.data != null && _createCenterViewModel.isOutStateLoading) {
                  _handleCreateOrUpdateStateChanged(snapshot.data!);
                }
                return _getCreateCentersScreenContent();
              },
            ),
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
          child: StreamBuilder<ModelCentersResponseRemote>(
              stream: _createCenterViewModel.outputCenterData,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data?.data?.isNotEmpty == true) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if(_createCenterViewModel.isCenterLoading) {
                      if(services!=null) {
                        _createCenterViewModel.isCenterLoading = false;
                        _setCenterData(snapshot);
                      }
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
                              child: _createCenterViewModel
                                          .createOrUpdateCenter.image ==
                                      null
                                  ? _centerId != null ? ClipOval(child: Image.network("${snapshot.data?.data![0].image}",fit: BoxFit.cover)) : SvgPicture.asset(ImageAssets.avatarIcon,
                                      fit: BoxFit.cover)
                                  : ClipOval(
                                    child: Image.file(_createCenterViewModel
                                        .createOrUpdateCenter.image!,fit: BoxFit.cover),
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
                              hint: AppStrings.enterCenterName.tr(),
                              title: AppStrings.centerName.tr(),
                              suffixIcon: "",
                              obscureText: false,
                              inputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings.enterCenterName.tr();
                                } else {
                                  null;
                                }
                                return null;
                              },
                              controller: _centerNameController,
                              takeValue: (value) {
                                _centerNameController.text = value;
                                _createCenterViewModel
                                    .createOrUpdateCenter.centerName = value;
                              }),
                          const SizedBox(height: AppSize.s16),
                          MyTextField(
                              hint: AppStrings.enterAddress.tr(),
                              title: AppStrings.address.tr(),
                              suffixIcon: "",
                              obscureText: false,
                              inputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings.enterAddress.tr();
                                } else {
                                  null;
                                }
                                return null;
                              },
                              controller: _addressController,
                              takeValue: (value) {
                                _addressController.text = value;
                                _createCenterViewModel
                                    .createOrUpdateCenter.address = value;
                              }),
                          const SizedBox(height: AppSize.s16),
                          MyTextFieldWithPhoneCode(
                              hint: AppStrings.enter_phone_number.tr(),
                              title: AppStrings.phone_number.tr(),
                              readOnly: false,
                              defaultCountryCode: getIsoCode(_countryCodeController.text) ?? "SA",
                              takeValue: (value) {
                                _phoneController.text = value;
                                _createCenterViewModel.createOrUpdateCenter.phone = "";
                                _createCenterViewModel.createOrUpdateCenter.phone = _countryCodeController.text + value;
                              },
                              takeCountryCode: (code) {
                                _countryCodeController.text = code;
                                _createCenterViewModel.createOrUpdateCenter.phone = "";
                                _createCenterViewModel.createOrUpdateCenter.phone = code + _phoneController.text;
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
                          StreamBuilder<ModelServicesResponseRemote>(
                            stream: _createCenterViewModel.outputServicesData,
                            builder: (context, serviceSnapshot) {
                              if (serviceSnapshot.hasData &&
                                  serviceSnapshot.data?.data?.isNotEmpty == true) {
                                if (_createCenterViewModel.isServicesLoading) {
                                  _createCenterViewModel.isServicesLoading = false;
                                  services = serviceSnapshot.data;
                                }
                              }
                              return MyTextField(
                                hint: AppStrings.selectServices.tr(),
                                title: AppStrings.services.tr(),
                                suffixIcon: ImageAssets.arrowDownIcon,
                                readOnly: true,
                                obscureText: false,
                                inputType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppStrings.selectServices.tr();
                                  } else {
                                    null;
                                  }
                                  return null;
                                },
                                controller: _servicesController,
                                takeValue: (value) {},
                                action: () {
                                  if(services!=null) {
                                    _openBottomSheetServices(context, services);
                                  }
                                },
                              );
                            },
                          ),
                          const SizedBox(height: AppSize.s16),
                          StreamBuilder<ModelEmployeesResponseRemote>(
                            stream: _createCenterViewModel.outputEmployeesData,
                            builder: (context, employeesSnapshot) {
                              if (employeesSnapshot.hasData &&
                                  employeesSnapshot.data?.data?.isNotEmpty == true) {
                                if (_createCenterViewModel.isEmployeesLoading) {
                                  _createCenterViewModel.isEmployeesLoading = false;
                                  employees = employeesSnapshot.data;
                                  print("EmployeeLog ${employees?.data?.length}");
                                }
                              }
                              return MyTextField(
                                  hint: AppStrings.enterEmployeeName.tr(),
                                  title: AppStrings.employeeName.tr(),
                                  suffixIcon: ImageAssets.arrowDownIcon,
                                  readOnly: true,
                                  obscureText: false,
                                  inputType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppStrings.enterEmployeeName.tr();
                                    } else {
                                      null;
                                    }
                                    return null;
                                  },
                                  controller: _employeeNameController,
                                  takeValue: (value) {},
                                  action: () {
                                    if(employees!=null){
                                      _openBottomSheetEmployee(context, employees);
                                    }
                                  });
                            },
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
                                  _createCenterViewModel.createOrUpdateCenter
                                      .openTime = _startTimeController.text;
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
                                  _createCenterViewModel.createOrUpdateCenter
                                      .closedTime = _endTimeController.text;
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
                                      value: AppStrings.open.tr(),
                                      activeColor: ColorManager.colorRedB2,
                                      groupValue: _selectedStatus,
                                      onChanged: (value) {
                                        setState(() {
                                          _createCenterViewModel
                                              .createOrUpdateCenter
                                              .status = CenterStatus.open;
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
                                      value: AppStrings.closed.tr(),
                                      activeColor: ColorManager.colorRedB2,
                                      groupValue: _selectedStatus,
                                      onChanged: (value) {
                                        setState(() {
                                          _createCenterViewModel
                                              .createOrUpdateCenter
                                              .status = CenterStatus.closed;
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
                );
              }),
        )),
        const SizedBox(height: AppSize.s20),
        StreamBuilder<ModelCreateOrUpdateCenterResponseRemote>(
          stream: _createCenterViewModel.outputCreateOrUpdateCenterData,
          builder: (ctx, createCenterSnapshot) {
            if (createCenterSnapshot.data != null && createCenterSnapshot.data?.status == true) {
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
                  if (_centerId == null && _createCenterViewModel.createOrUpdateCenter.image == null) {
                    context.showErrorToast(AppStrings.select_center_image.tr());
                    return;
                  }

                  if (_centerId == null) {
                    _createCenterViewModel.createCenter();
                  } else {
                    _createCenterViewModel.updateCenter();
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
      _createCenterViewModel.createOrUpdateCenter.image = File(image.path ?? "");
      setState(() {});
    }
  }

  _imageFromCamera() async{
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    if(image!=null) {
      _createCenterViewModel.createOrUpdateCenter.image = File(image.path ?? "");
      setState(() {});
    }
  }

  void _openBottomSheetServices(BuildContext context, ModelServicesResponseRemote? services) {
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
          return CenterServiceSelectedItem(AppStrings.selectServices.tr(), services?.data, selectedService: (mServices){
            _servicesController.text = mServices.map((service) => service.name).join(' , ');
            _createCenterViewModel.services = mServices;
            services!.data!.forEach((item) {
              item.selected = mServices.contains(item); // Update the selected state directly
            });
            Navigator.of(ctx).pop();
          });
        },
      );
    });
  }

  void _openBottomSheetEmployee(BuildContext context, ModelEmployeesResponseRemote? emplyees) {
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
          return CenterEmployeeSelectedItem(AppStrings.employees.tr(), emplyees?.data, selectedEmployee: (mEmployee){
            _employeeNameController.text = "${mEmployee.name}";
            _createCenterViewModel.createOrUpdateCenter.employeeId = "${mEmployee.id}";
            Navigator.of(ctx).pop();
          });
        },
      );
    });
  }

  _handleCreateOrUpdateStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _createCenterViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _createCenterViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _centerNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _countryCodeController.dispose();
    _servicesController.dispose();
    _employeeNameController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _createCenterViewModel.dispose();
    super.dispose();
  }

}

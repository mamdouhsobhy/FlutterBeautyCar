import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/presentation/employeePageScreen/viewmodel/employee_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../resources/assetsManager.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/fontManager.dart';
import '../../../../resources/stringManager.dart';
import '../../../../resources/styleManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../../utils/loading_page.dart';
import '../../../../utils/shared_appbar.dart';
import '../../../../utils/shared_text_field.dart';
import '../../homeSharedViews/employee_item_card.dart';
import '../../routeManager/home_routes_manager.dart';

class EmployeePageScreen extends StatefulWidget {
  const EmployeePageScreen({super.key});

  @override
  State<EmployeePageScreen> createState() => _EmployeePageScreenState();
}

class _EmployeePageScreenState extends State<EmployeePageScreen> {

  final EmployeeViewModel _employeeViewModel = instance<EmployeeViewModel>();

  final TextEditingController _searchController = TextEditingController();

  List<Data> filteredEmployees = [];

  _bind() {
    _employeeViewModel.start();
  }

  void _searchEmployees(String query) {
    setState(() {
      filteredEmployees = _employeeViewModel.employeesList.where((employee) {
        return employee.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _refreshEmployees() {
    _employeeViewModel.resetPage();
    _employeeViewModel.employeesList.clear();
    filteredEmployees.clear();
    _searchController.clear();
    _employeeViewModel.getEmployees();
  }

  @override
  void initState() {
    _bind();
    super.initState();
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
          appBar: MyAppBar(title: AppStrings.employees.tr()),
          body: SafeArea(
              child: StreamBuilder<FlowState>(
                stream: _employeeViewModel.outputState,
                builder: (context, snapshot) {
                  if (snapshot.data != null && _employeeViewModel.isOutStateLoading) {
                    _handleEmployeesStateChanged(snapshot.data!);
                  }
                  return _getEmployeeScreenContent();
                },
              ),
          ),
        ));
  }

  Widget _getEmployeeScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: AppSize.s10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppPadding.p10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s15), // Rounded corners
                  border:
                  Border.all(color: Colors.grey), // Optional: visible border
                ),
                child: SvgPicture.asset(ImageAssets.filterIcon),
              ),
              const SizedBox(width: AppSize.s10), // Optional: spacing between icon and text field
              Expanded(
                child: MyTextField(
                  hint: "",
                  title: "",
                  suffixIcon: ImageAssets.searchIcon,
                  obscureText: false,
                  inputType: TextInputType.text,
                  controller: _searchController,
                  takeValue: (value) {
                    _searchEmployees(value);
                    _searchController.text = value;
                  },
                  validator: null,
                  paddingHorizontal: AppPadding.p0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s10,),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              _refreshEmployees();
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      height: constraints.maxHeight,
                      child: StreamBuilder<ModelEmployeesResponseRemote>(
                        stream: _employeeViewModel.outputEmployeesData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data?.data?.isNotEmpty == true) {
                            for (var employee in snapshot.data!.data!) {
                              if (!_employeeViewModel.employeesList.contains(employee)) {
                                _employeeViewModel.employeesList.add(employee);
                              }
                            }
                          }

                          if (_employeeViewModel.employeesList.isEmpty) {
                            return SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                height: constraints.maxHeight,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(ImageAssets.ordersIcon),
                                      const SizedBox(height: AppSize.s10),
                                      Text(
                                        "No Employees Found",
                                        style: getRegularStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.size16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );

                          } else {
                            if (_searchController.text.isEmpty) {
                              filteredEmployees = _employeeViewModel.employeesList;
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p14, vertical: AppPadding.p5),
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: filteredEmployees.length,
                                itemBuilder: (context, index) {
                                  return EmployeeItemCard(
                                    employee: filteredEmployees[index],
                                    fun: (employeeId,actionType) {
                                        Future.delayed(const Duration(milliseconds: 500), () {
                                          Navigator.pushNamed(
                                            context,
                                            HomeRoutes.employeeDetailsRoute,
                                            arguments: {'employeeId': "$employeeId"},
                                          ).then((result) {
                                            // Refresh employees when returning from details screen
                                            if (result == true) {
                                              _refreshEmployees();
                                            }
                                          });
                                        });
                                    },
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Positioned(
                      bottom: AppPadding.p50,
                      right: AppPadding.p16,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, HomeRoutes.createEmployeeRoute)
                              .then((result) {
                            // Refresh employees when returning from create screen
                            if (result == true) {
                              _refreshEmployees();
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(AppPadding.p10),
                          decoration: BoxDecoration(
                            color: ColorManager.colorRedB2,
                            borderRadius: BorderRadius.circular(AppSize.s15),
                            border: Border.all(color: ColorManager.colorRedB2),
                          ),
                          child: SvgPicture.asset(ImageAssets.plusIcon),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  _handleEmployeesStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _employeeViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _employeeViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _employeeViewModel.dispose();
    super.dispose();
  }

}

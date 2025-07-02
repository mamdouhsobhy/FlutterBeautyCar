import 'package:beauty_car/home/presentation/employeeDetailsPageScreen/viewmodel/employee_details_viewmodel.dart';
import 'package:beauty_car/resources/fontManager.dart';
import 'package:beauty_car/resources/styleManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../resources/assetsManager.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/constantsManager.dart';
import '../../../../resources/stringManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../../utils/loading_page.dart';
import '../../../../utils/shared_appbar.dart';
import '../../../data/response/employees/employees.dart';
import '../../employeeAppointmentPageScreen/view/employee_appointment_page_screen.dart';
import '../../employeeInfoPageScreen/employee_info_page_screen.dart';
import '../../employee_review_page_screen/view/employee_review_page_screen.dart';
import '../../routeManager/home_routes_manager.dart';

class EmployeeDetailsPageScreen extends StatefulWidget {
  const EmployeeDetailsPageScreen({super.key});

  @override
  State<EmployeeDetailsPageScreen> createState() => _EmployeeDetailsPageScreenState();
}

class _EmployeeDetailsPageScreenState extends State<EmployeeDetailsPageScreen> {
  final EmployeeDetailsViewModel _employeeDetailsViewModel = instance<EmployeeDetailsViewModel>();
  Data? employee;
  final PageController _pageController = PageController();
  int selectedIndex = 0;
  String? _employeeId;

  _bind() {
    _employeeDetailsViewModel.start();
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
      if (_employeeId != null && !_employeeDetailsViewModel.isCenterFirstLoad) {
        _employeeDetailsViewModel.isCenterFirstLoad = true;
        _employeeDetailsViewModel.getEmployeeDetails("$_employeeId");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> pageList = [
      AppStrings.profile.tr(),
      AppStrings.appointment.tr(),
      AppStrings.review.tr(),
    ];

    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context,true);
        return true;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: ColorManager.white,
          appBar: MyAppBar(title: ""),
          body: SafeArea(
            child: StreamBuilder<FlowState>(
              stream: _employeeDetailsViewModel.outputState,
              builder: (context, snapshot) {
                if (snapshot.data != null && _employeeDetailsViewModel.isOutStateLoading) {
                  _handleEmployeesStateChanged(snapshot.data!);
                }
                return _getEmployeeDetailsScreenContent(pageList);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _getEmployeeDetailsScreenContent(List<String> pageList) {
    return StreamBuilder<ModelEmployeesResponseRemote>(
      stream: _employeeDetailsViewModel.outputEmployeeData,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.data?.isNotEmpty == true) {
          if (_employeeDetailsViewModel.isEmployeeLoading) {
            employee = snapshot.data!.data![0];
            _employeeDetailsViewModel.isEmployeeLoading = false;
          }
        }

        if (employee == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSize.s10),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: AppSize.s80,
                    height: AppSize.s80,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: SvgPicture.asset(ImageAssets.avatarIcon, fit: BoxFit.cover),
                  ),
                  GestureDetector(
                    onTap: () {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.pushNamed(
                          context,
                          HomeRoutes.createEmployeeRoute,
                          arguments: {'employeeId': "${employee?.id}"},
                        ).then((result) {
                          if (result == true && _employeeId != null) {
                            _employeeDetailsViewModel.getEmployeeDetails("$_employeeId");
                          }
                        });
                      });
                    },
                    child: Card(
                      color: ColorManager.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s30)),
                      child: Container(
                        width: AppSize.s30,
                        height: AppSize.s30,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Icon(Icons.edit,
                            size: AppSize.s18, color: ColorManager.colorRedB2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.s6),
            Column(
              children: [
                Text("${employee?.name}",
                    style: getBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.size16)),
                Text("${employee?.email}",
                    style: getRegularStyle(
                        color: ColorManager.colorGray72, fontSize: FontSize.size12))
              ],
            ),
            const SizedBox(height: AppSize.s10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(pageList.length, (index) {
                final isSelected = index == selectedIndex;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppSize.s20),
                    onTap: () {
                      setState(() => selectedIndex = index);
                      _pageController.animateToPage(
                        selectedIndex,
                        duration: const Duration(milliseconds: AppConstants.sliderAnimationTime),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p16, vertical: AppPadding.p12),
                      decoration: BoxDecoration(
                        color: isSelected ? ColorManager.colorRedB2 : ColorManager.colorRedFA,
                        borderRadius: BorderRadius.circular(AppSize.s8),
                      ),
                      child: Text(
                        pageList[index],
                        style: getRegularStyle(
                            fontSize: FontSize.size14,
                            color: isSelected ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: AppSize.s10),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pageList.length,
                itemBuilder: (ctx, index) {
                  switch (index) {
                    case 0:
                      return KeyedSubtree(
                        key: ValueKey("info_${employee?.id}"),
                        child: EmployeeInfoPageScreen(employee: employee),
                      );
                    case 1:
                      return KeyedSubtree(
                        key: ValueKey("appointments_${employee?.id}"),
                        child: EmployeeAppointmentPageScreen(
                          key: ValueKey("appointment_${employee?.id}"),
                          employeeId: "$_employeeId",
                        ),
                      );
                    case 2:
                      return KeyedSubtree(
                        key: ValueKey("reviews_${employee?.id}"),
                        child: EmployeeReviewPageScreen(
                          key: ValueKey("review_page_${employee?.id}"),
                          employeeId: "$_employeeId",
                        ),
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleEmployeesStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _employeeDetailsViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else {
        _employeeDetailsViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _employeeDetailsViewModel.dispose();
    super.dispose();
  }
}

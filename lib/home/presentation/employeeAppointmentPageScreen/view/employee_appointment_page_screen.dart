import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/presentation/employeeAppointmentPageScreen/viewmodel/appointment_orders_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../resources/assetsManager.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/fontManager.dart';
import '../../../../resources/styleManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../../utils/loading_page.dart';
import '../../homeSharedViews/employee_appointment_item_card.dart';
import '../../homeSharedViews/employee_item_card.dart';
import '../../routeManager/home_routes_manager.dart';

class EmployeeAppointmentPageScreen extends StatefulWidget {
  String employeeId;
  EmployeeAppointmentPageScreen({super.key,required this.employeeId});

  @override
  State<EmployeeAppointmentPageScreen> createState() => _EmployeeAppointmentPageScreenState();
}

class _EmployeeAppointmentPageScreenState extends State<EmployeeAppointmentPageScreen> {

  final AppointmentOrdersViewModel _appointmentOrdersViewModel = instance<AppointmentOrdersViewModel>();

  final ScrollController _scrollController = ScrollController();

  List<Data> filteredOrders = [];

  _bind() {
    _appointmentOrdersViewModel.start();
  }

  @override
  void initState() {
    _appointmentOrdersViewModel.appointmentOrderRequest.empId = widget.employeeId;
    _bind();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        _appointmentOrdersViewModel.page++ ;
        _appointmentOrdersViewModel.appointmentOrderRequest.page = _appointmentOrdersViewModel.page;
        _appointmentOrdersViewModel.getAppointmentOrders();
      }
    });
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
          body: SafeArea(
            child: StreamBuilder<FlowState>(
              stream: _appointmentOrdersViewModel.outputState,
              builder: (context, snapshot) {
                if (snapshot.data != null && _appointmentOrdersViewModel.isOutStateLoading) {
                  _handleOrdersStateChanged(snapshot.data!);
                }
                return _getAppointmentOrdersContentScreen();
              },
            ),
          ),
        ));
  }

  Widget _getAppointmentOrdersContentScreen(){
    return RefreshIndicator(
      onRefresh: () async {
        _appointmentOrdersViewModel.page = 1;
        _appointmentOrdersViewModel.appointmentOrderRequest.page = 1;
        _appointmentOrdersViewModel.appointmentOrdersList = [];
        _appointmentOrdersViewModel.appointmentOrdersList.clear();
        filteredOrders.clear();
        _appointmentOrdersViewModel.resetPage();
        _appointmentOrdersViewModel.getAppointmentOrders();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                height: constraints.maxHeight,
                child: StreamBuilder<ModelOrdersResponseRemote>(
                  stream: _appointmentOrdersViewModel.outputAppointmentOrdersData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data?.data?.isNotEmpty == true) {
                      for (var order in snapshot.data!.data!) {
                        if (!_appointmentOrdersViewModel.appointmentOrdersList.contains(order)) {
                          _appointmentOrdersViewModel.appointmentOrdersList.add(order);
                        }
                      }
                    }

                    if (_appointmentOrdersViewModel.appointmentOrdersList.isEmpty) {
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
                                  "No Orders Found",
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
                      filteredOrders = _appointmentOrdersViewModel.appointmentOrdersList;
                      return ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppPadding.p8, horizontal: AppPadding.p16),
                            child: EmployeeAppointmentItemCard(order: filteredOrders[index],fun: (orderId){

                            }),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }

  _handleOrdersStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _appointmentOrdersViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _appointmentOrdersViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _appointmentOrdersViewModel.dispose();
    super.dispose();
  }

}

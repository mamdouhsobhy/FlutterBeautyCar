import 'package:beauty_car/home/data/response/completeOrder/complete_order.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/presentation/employeeScanPageScreen/viewmodel/scan_viewmodel.dart';
import 'package:beauty_car/home/presentation/homeSharedViews/order_scan_item_card.dart';
import 'package:beauty_car/utils/toast_utils.dart';
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
import '../../qrScannerScreen/qr_scanner_screen.dart';
import '../../routeManager/home_routes_manager.dart';

class EmployeeScanPageScreen extends StatefulWidget {
  const EmployeeScanPageScreen({super.key});

  @override
  State<EmployeeScanPageScreen> createState() => _EmployeeScanPageScreenState();
}

class _EmployeeScanPageScreenState extends State<EmployeeScanPageScreen> {
  final ScanViewModel _scanViewModel = instance<ScanViewModel>();

  final TextEditingController _searchController = TextEditingController();

  List<Data> filteredOrders = [];

  _bind() {
    _scanViewModel.start();
  }

  void _searchEmployees(String query) {
    setState(() {
      filteredOrders = _scanViewModel.ordersList.where((employee) {
        return employee.serviceName!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _refreshOrders() {
    _scanViewModel.ordersData.add(ModelOrdersResponseRemote());
    _scanViewModel.resetPage();
    _scanViewModel.ordersList.clear();
    filteredOrders.clear();
    _searchController.clear();
    _scanViewModel.getRecentOrders();
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
          appBar: MyAppBar(title: AppStrings.requests_awaiting_payment.tr()),
          body: SafeArea(
            child: StreamBuilder<FlowState>(
              stream: _scanViewModel.outputState,
              builder: (context, snapshot) {
                if (snapshot.data != null && _scanViewModel.isOutStateLoading) {
                  handleOrdersStateChanged(snapshot.data!);
                }
                return _getOrdersScreenContent();
              },
            ),
          ),
        ));
  }

  Widget _getOrdersScreenContent() {
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
              _refreshOrders();
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      height: constraints.maxHeight,
                      child: StreamBuilder<ModelOrdersResponseRemote>(
                        stream: _scanViewModel.outputOrdersData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data?.data?.isNotEmpty == true) {
                            for (var order in snapshot.data!.data!) {
                              if (!_scanViewModel.ordersList.contains(order)) {
                                _scanViewModel.ordersList.add(order);
                              }
                            }
                          }

                          if (_scanViewModel.ordersList.isEmpty) {
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
                            if (_searchController.text.isEmpty) {
                              filteredOrders = _scanViewModel.ordersList;
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p14, vertical: AppPadding.p5),
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: filteredOrders.length,
                                itemBuilder: (context, index) {
                                  return OrderScanItemCard(
                                      orders: filteredOrders[index],
                                      fun: (order , actionType) {
                                        if (actionType == "details") {
                                          _navigateToOrderDetails("${order.id}");
                                        } else {
                                          _openQrScannerAndRefresh(order);
                                        }
                                      });
                                },
                              ),
                            );
                          }
                        },
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
        completeOrder()
      ],
    );
  }

  _navigateToOrderDetails(String orderId){
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushNamed(
        context,
        HomeRoutes.reserveDetailsRoute,
        arguments: {'orderId': "$orderId"},
      );
    });
  }

  Future<void> _openQrScannerAndRefresh(Data order) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const QrScannerScreen()),
    );
    context.showInfoToast("$result");
    if (result != null) {

      print("Scanned QR: $result");
    }
  }

  Widget completeOrder(){
    return StreamBuilder<ModelCompleteOrderResponseRemote>(
        stream: _scanViewModel.outputCompleteOrderData,
        builder: (ctx, snapshot)
    {
      if (snapshot.data != null && snapshot.data?.status == true) {
        if (_scanViewModel.isCompleteOrderLoading) {
          _scanViewModel.isCompleteOrderLoading = false;
           _refreshOrders();
        }
      }
      return SizedBox();
    });
  }

  handleOrdersStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _scanViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _scanViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scanViewModel.dispose();
    super.dispose();
  }

}

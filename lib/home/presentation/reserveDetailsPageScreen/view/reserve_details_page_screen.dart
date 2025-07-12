import 'package:beauty_car/home/presentation/homeSharedViews/reserve_details_item.dart';
import 'package:beauty_car/home/presentation/reserveDetailsPageScreen/viewmodel/order_details_viewmodel.dart';
import 'package:beauty_car/resources/fontManager.dart';
import 'package:beauty_car/resources/styleManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/stringManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../../utils/loading_page.dart';
import '../../../../utils/shared_appbar.dart';
import '../../../data/response/orders/orders.dart';

class ReserveDetailsPageScreen extends StatefulWidget {
  const ReserveDetailsPageScreen({super.key});

  @override
  State<ReserveDetailsPageScreen> createState() =>
      _ReserveDetailsPageScreenState();
}

class _ReserveDetailsPageScreenState extends State<ReserveDetailsPageScreen> {

  final OrderDetailsViewModel _orderViewModel = instance<OrderDetailsViewModel>();

  String? _orderId;

  _bind() {
    _orderViewModel.start();
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
      _orderId = args['orderId']?.toString().isEmpty == true ? null : args['orderId'];
      if (_orderId != null && _orderViewModel.isCenterFirstLoad == false) {
        _orderViewModel.isCenterFirstLoad = true;
        _orderViewModel.getOrderDetails("$_orderId");
      }
    } else {
      debugPrint("Arguments are not a Map<String, dynamic>");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        return true;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: ColorManager.white,
            appBar: MyAppBar(title: AppStrings.reserveDetails.tr()),
            body: SafeArea(
                child:
                StreamBuilder<FlowState>(
                  stream: _orderViewModel.outputState,
                  builder: (context, snapshot) {
                    if (snapshot.data != null && _orderViewModel.isOutStateLoading) {
                      _handleOrderDetailsStateChanged(snapshot.data!);
                    }
                    return _getReserveDetailsScreenContent();
                  },
                ),
                ),
          )),
    );
  }

  Widget _getReserveDetailsScreenContent() {
    return StreamBuilder<ModelOrdersResponseRemote>(
        stream: _orderViewModel.outputOrderData,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: RefreshIndicator(
              onRefresh: () async {
                _orderViewModel.getOrderDetails("$_orderId");
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: AppSize.s20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppStrings.status.tr(),
                            style: getBoldStyle(
                                color: ColorManager.colorRedB2,
                                fontSize: FontSize.size18)),
                        const SizedBox(width: AppSize.s6),
                        Card(
                            color: ColorManager.colorGrayE4,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s4)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p12,
                                  vertical: AppPadding.p4),
                              child: Text(_getOrderStatus(snapshot.data?.data![0].status),
                                  style: getMediumStyle(
                                      color: ColorManager.colorGray77,
                                      fontSize: FontSize.size18)),
                            ))
                      ],
                    ),
                    const SizedBox(height: AppSize.s25),
                    Text(AppStrings.carType.tr(),
                        style: getBoldStyle(
                            color: ColorManager.colorRedB2,
                            fontSize: FontSize.size18)),
                    const SizedBox(height: AppSize.s4),
                    Card(
                      color: ColorManager.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s4)),
                      child: Column(
                        children: [
                          ReserveDetailsItem(
                              title: AppStrings.carModel.tr(), value: "${snapshot.data?.data![0].carBrand}"),
                          Divider(
                              height: AppSize.s1,
                              color: ColorManager.colorGrayD6),
                          ReserveDetailsItem(
                              title: AppStrings.chassisNumber.tr(),
                              value: "${snapshot.data?.data![0].carModel}"),
                          Divider(
                              height: AppSize.s1,
                              color: ColorManager.colorGrayD6),
                          ReserveDetailsItem(
                              title: AppStrings.color.tr(), value: "${snapshot.data?.data![0].carColor}")
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s25),
                    Text(AppStrings.reserveDetails.tr(),
                        style: getBoldStyle(
                            color: ColorManager.colorRedB2,
                            fontSize: FontSize.size18)),
                    const SizedBox(height: AppSize.s4),
                    Card(
                        color: ColorManager.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s4)),
                        child: Column(
                          children: [
                            ReserveDetailsItem(
                                title: AppStrings.centerName.tr(), value: "${snapshot.data?.data![0].shopName}"),
                            Divider(
                                height: AppSize.s1,
                                color: ColorManager.colorGrayD6),
                            ReserveDetailsItem(
                                title: AppStrings.orderId.tr(),
                                value: "${snapshot.data?.data![0].id}"),
                            Divider(
                                height: AppSize.s1,
                                color: ColorManager.colorGrayD6),
                            ReserveDetailsItem(
                                title: AppStrings.date.tr(), value: "${snapshot.data?.data![0].date}"),
                            Divider(
                                height: AppSize.s1,
                                color: ColorManager.colorGrayD6),
                            ReserveDetailsItem(
                                title: AppStrings.time.tr(), value: "${snapshot.data?.data![0].time}"),
                            Divider(
                                height: AppSize.s1,
                                color: ColorManager.colorGrayD6),
                            ReserveDetailsItem(
                                title: AppStrings.address.tr(), value: "${snapshot.data?.data![0].addressName}")
                          ],
                        )),
                    const SizedBox(height: AppSize.s25),
                    Text(AppStrings.serviceDetails.tr(),
                        style: getBoldStyle(
                            color: ColorManager.colorRedB2,
                            fontSize: FontSize.size18)),
                    const SizedBox(height: AppSize.s4),
                    Card(
                        color: ColorManager.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s4)),
                        child: Column(
                          children: [
                            ReserveDetailsItem(
                                title: AppStrings.serviceLocation.tr(),
                                value: "${snapshot.data?.data![0].addressName}"),
                            Divider(
                                height: AppSize.s1,
                                color: ColorManager.colorGrayD6),
                            ReserveDetailsItem(
                                title: AppStrings.serviceName.tr(),
                                value: "${snapshot.data?.data![0].serviceName}"),
                          ],
                        )),
                    const SizedBox(height: AppSize.s25),
                    Text(AppStrings.customerDetails.tr(),
                        style: getBoldStyle(
                            color: ColorManager.colorRedB2,
                            fontSize: FontSize.size18)),
                    const SizedBox(height: AppSize.s4),
                    Card(
                        color: ColorManager.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s4)),
                        child: Column(
                          children: [
                            ReserveDetailsItem(
                                title: AppStrings.name.tr(), value: "${snapshot.data?.data![0].clientName}"),
                          ],
                        )),
                    const SizedBox(height: AppSize.s25),
                  ],
                ),
              ),
            ),
          );
        });
  }

  String _getOrderStatus(int? status){
    if(status == 1){
      return AppStrings.pending.tr();
    }else if(status == 2){
      return AppStrings.accepted.tr();
    }else if(status == 3){
      return AppStrings.completed.tr();
    }else{
      return AppStrings.cancelled.tr();
    }
  }

  _handleOrderDetailsStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _orderViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _orderViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _orderViewModel.dispose();
    super.dispose();
  }

}

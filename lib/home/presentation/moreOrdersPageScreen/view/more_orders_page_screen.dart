import 'package:beauty_car/home/presentation/moreOrdersPageScreen/viewmodel/more_orders_viewmodel.dart';
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
import '../../../data/response/orders/orders.dart';
import '../../homeSharedViews/service_request_card.dart';
import '../../routeManager/home_routes_manager.dart';

class MoreOrdersPageScreen extends StatefulWidget {
  const MoreOrdersPageScreen({super.key});

  @override
  State<MoreOrdersPageScreen> createState() => _MoreOrdersPageScreenState();
}

class _MoreOrdersPageScreenState extends State<MoreOrdersPageScreen> {
  final MoreOrdersViewModel _moreOrdersViewModel =
      instance<MoreOrdersViewModel>();
  final ScrollController _scrollController = ScrollController();

  List<Data> filteredOrders = [];

  _bind() {
    _moreOrdersViewModel.start();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        _moreOrdersViewModel.page++;
        _moreOrdersViewModel.orderRequest.page = _moreOrdersViewModel.page;
        _moreOrdersViewModel.getRecentOrders();
      }
    });
  }

  _navigateToOrderDetails(String orderId) {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushNamed(
        context,
        HomeRoutes.reserveDetailsRoute,
        arguments: {'orderId': "$orderId"},
      );
    });
  }

  resetAndRefresh() {
    _moreOrdersViewModel.ordersData
        .add(ModelOrdersResponseRemote(data: List.empty()));
    _moreOrdersViewModel.resetPage();
    filteredOrders.clear();
    _moreOrdersViewModel.getRecentOrders();
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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MyAppBar(title: AppStrings.serviceRequests.tr()),
        ),
        body: SafeArea(
          child: StreamBuilder<FlowState>(
            stream: _moreOrdersViewModel.outputState,
            builder: (context, snapshot) {
              if (snapshot.data != null &&
                  _moreOrdersViewModel.isOutStateLoading) {
                _handleMoreOrdersStateChanged(snapshot.data!);
              }
              return _getMoreOrdersScreenContent();
            },
          ),
        ),
      ),
    );
  }

  Widget _getMoreOrdersScreenContent() {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            color: ColorManager.colorRedB2,
            onRefresh: () async {
              _moreOrdersViewModel.resetPage();
              filteredOrders.clear();
              _moreOrdersViewModel.getRecentOrders();
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return StreamBuilder<ModelOrdersResponseRemote>(
                  stream: _moreOrdersViewModel.outputOrdersData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data?.data?.isNotEmpty == true) {
                      for (var order in snapshot.data!.data!) {
                        if (!_moreOrdersViewModel.ordersList.contains(order)) {
                          _moreOrdersViewModel.ordersList.add(order);
                        }
                      }
                    }

                    if (_moreOrdersViewModel.ordersList.isEmpty) {
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
                      filteredOrders = _moreOrdersViewModel.ordersList;
                      return ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppPadding.p8,
                              horizontal: AppPadding.p16,
                            ),
                            child: ServiceRequestCard(
                              orders: filteredOrders[index],
                              fun: (orderId) {
                                _navigateToOrderDetails("$orderId");
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  _handleMoreOrdersStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _moreOrdersViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _moreOrdersViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _moreOrdersViewModel.dispose();
    super.dispose();
  }
}

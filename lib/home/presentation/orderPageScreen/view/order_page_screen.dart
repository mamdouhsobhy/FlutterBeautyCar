import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/data/response/updateOrderStatus/update_order_status.dart';
import 'package:beauty_car/home/presentation/orderPageScreen/viewmodel/orders_viewmodel.dart';
import 'package:beauty_car/home/presentation/routeManager/home_routes_manager.dart';
import 'package:beauty_car/resources/fontManager.dart';
import 'package:beauty_car/resources/styleManager.dart';
import 'package:beauty_car/utils/Constants.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../resources/assetsManager.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/stringManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../../utils/loading_page.dart';
import '../../../../utils/shared_appbar.dart';
import '../../../../utils/shared_text_field.dart';
import '../../homeSharedViews/order_request_item_card.dart';

class OrderPageScreen extends StatefulWidget {
  const OrderPageScreen({super.key});

  @override
  State<OrderPageScreen> createState() => _OrderPageScreenState();
}

class _OrderPageScreenState extends State<OrderPageScreen> {

  final OrdersViewModel _ordersViewModel = instance<OrdersViewModel>();

  final ScrollController _scrollController = ScrollController();

  final TextEditingController _searchController = TextEditingController();

  final List<String> statusList = [
    AppStrings.statusPending.tr(),
    AppStrings.statusApproved.tr(),
    AppStrings.statusCompleted.tr(),
    AppStrings.statusCancelled.tr()
  ];

  int selectedIndex = 0;
  int mActionType = OrderStatus.accepted;
  List<Data> filteredOrders = [];

  _bind() {
    _ordersViewModel.start();
  }

  void _searchOrders(String query) {
    setState(() {
      filteredOrders = _ordersViewModel.ordersList.where((order) {
        return order.serviceName!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
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

  _resetAndRefresh(){
    _ordersViewModel.ordersData.add(ModelOrdersResponseRemote(data: List.empty()));
    _ordersViewModel.resetPage();
    filteredOrders.clear();
    _ordersViewModel.getOrders();
  }

  _showUpdateOrderStatusMessage(){
    if(mActionType == OrderStatus.accepted){
      context.showSuccessToast(AppStrings.order_accepted_successfully.tr());
    }else{
      context.showSuccessToast(AppStrings.order_cancelled_successfully.tr());
    }

    _resetAndRefresh();
  }

  @override
  void initState() {
    _bind();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        _ordersViewModel.page++ ;
        _ordersViewModel.orderRequest.page = _ordersViewModel.page;
        _ordersViewModel.getOrders();
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
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: MyAppBar(title: AppStrings.serviceRequests.tr()),
          ),
          body: SafeArea(
              child:
              SafeArea(
                child: StreamBuilder<FlowState>(
                  stream: _ordersViewModel.outputState,
                  builder: (context, snapshot) {
                    if (snapshot.data != null && _ordersViewModel.isOutStateLoading) {
                      _handleOrdersStateChanged(snapshot.data!);
                    }
                    return _getOrdersScreenContent();
                  },
                ),
              ),
              ),
        ));
  }

  Widget _getOrdersScreenContent() {
   return StreamBuilder<ModelUpdateOrderStatusResponseRemote>(
       stream: _ordersViewModel.outputUpdateOrderStatusData,
       builder: (context, snapshot)
   {
     if (snapshot.hasData && snapshot.data?.status == true) {
       WidgetsBinding.instance.addPostFrameCallback((_) {
         if(_ordersViewModel.isUpdateOrderLoading) {
           _ordersViewModel.isUpdateOrderLoading = false;
           _showUpdateOrderStatusMessage();
         }
       });
    }
     return Column(
       crossAxisAlignment: CrossAxisAlignment.stretch,
       mainAxisAlignment: MainAxisAlignment.start,
       mainAxisSize: MainAxisSize.min,
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
                   borderRadius: BorderRadius.circular(AppSize.s15),
                   // Rounded corners
                   border: Border.all(
                       color: Colors.grey), // Optional: visible border
                 ),
                 child: SvgPicture.asset(ImageAssets.filterIcon),
               ),
               const SizedBox(width: AppSize.s10),
               // Optional: spacing between icon and text field
               Expanded(
                 child: MyTextField(
                   hint: "",
                   title: "",
                   suffixIcon: ImageAssets.searchIcon,
                   obscureText: false,
                   inputType: TextInputType.text,
                   controller: _searchController,
                   validator: null,
                   takeValue: (value) {
                     _searchOrders(value);
                     _searchController.text = value;
                   },
                   paddingHorizontal: AppPadding.p0,
                 ),
               ),
             ],
           ),
         ),
         const SizedBox(height: AppSize.s20),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
           child: SingleChildScrollView(
             // scrollDirection: Axis.horizontal,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: List.generate(statusList.length, (index) {
                 final isSelected = index == selectedIndex;
                 return Expanded(
                   child: Padding(
                     padding:
                     const EdgeInsets.symmetric(horizontal: AppPadding.p4),
                     child: InkWell(
                       borderRadius: BorderRadius.circular(AppSize.s20),
                       onTap: () {
                         if (index == 0) {
                           _ordersViewModel.orderRequest.status =
                               OrderStatus.pending;
                         } else if (index == 1) {
                           _ordersViewModel.orderRequest.status =
                               OrderStatus.accepted;
                         } else if (index == 2) {
                           _ordersViewModel.orderRequest.status =
                               OrderStatus.completed;
                         } else if (index == 3) {
                           _ordersViewModel.orderRequest.status =
                               OrderStatus.cancelled;
                         }
                         selectedIndex = index;
                         _resetAndRefresh();
                         print('Selected: ${statusList[index]}');
                       },
                       child: Container(
                         alignment: Alignment.center,
                         padding: const EdgeInsets.symmetric(
                             horizontal: AppPadding.p12,
                             vertical: AppPadding.p8),
                         decoration: BoxDecoration(
                           color: isSelected
                               ? ColorManager.colorRedB2 // Selected: Red
                               : ColorManager.colorRedFA,
                           // Unselected: Light Red
                           borderRadius: BorderRadius.circular(AppSize.s20),
                         ),
                         child: Text(
                           statusList[index],
                           style: getRegularStyle(
                               fontSize: FontSize.size14,
                               color: isSelected ? Colors.white : Colors.black),
                         ),
                       ),
                     ),
                   ),
                 );
               }),
             ),
           ),
         ),
         const SizedBox(height: AppSize.s8),
         Expanded(
           child: RefreshIndicator(
             onRefresh: () async {
               _ordersViewModel.resetPage();
               filteredOrders.clear();
               _ordersViewModel.getOrders();
             },
             child: LayoutBuilder(
               builder: (context, constraints) {
                 return Stack(
                   children: [
                     Container(
                       height: constraints.maxHeight,
                       child: StreamBuilder<ModelOrdersResponseRemote>(
                         stream: _ordersViewModel.outputOrdersData,
                         builder: (context, snapshot) {
                           if (snapshot.hasData &&
                               snapshot.data?.data?.isNotEmpty == true) {
                             for (var center in snapshot.data!.data!) {
                               if (!_ordersViewModel.ordersList.contains(
                                   center)) {
                                 _ordersViewModel.ordersList.add(center);
                               }
                             }
                           }

                           if (_ordersViewModel.ordersList.isEmpty) {
                             return SingleChildScrollView(
                               physics: const AlwaysScrollableScrollPhysics(),
                               child: SizedBox(
                                 height: constraints.maxHeight,
                                 child: Center(
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment
                                         .center,
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
                             // if (_searchController.text.isEmpty) {
                             filteredOrders = _ordersViewModel.ordersList;
                             // }
                             print("ListSize ${filteredOrders.length}");
                             return ListView.builder(
                               controller: _scrollController,
                               physics: const AlwaysScrollableScrollPhysics(),
                               itemCount: filteredOrders.length,
                               itemBuilder: (context, index) {
                                 return Padding(
                                   padding: const EdgeInsets.symmetric(
                                       vertical: AppPadding.p8,
                                       horizontal: AppPadding.p16),
                                   child: OrderRequestItemCard(
                                       orders: filteredOrders[index],
                                       fun: (orderId, actionType) {
                                         if (actionType == "details") {
                                           _navigateToOrderDetails(orderId);
                                         } else if (actionType == "accept") {
                                           mActionType = OrderStatus.accepted;
                                           _ordersViewModel.updateOrderStatus(
                                               orderId, OrderStatus.accepted);
                                         } else {
                                           mActionType = OrderStatus.cancelled;
                                           _ordersViewModel.updateOrderStatus(
                                               orderId, OrderStatus.cancelled);
                                         }
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
           ),
         ),
       ],
     );
   });
  }

  _handleOrdersStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _ordersViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _ordersViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _ordersViewModel.dispose();
    super.dispose();
  }
}

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

class MoreOrdersPageScreen extends StatefulWidget {
  const MoreOrdersPageScreen({super.key});

  @override
  State<MoreOrdersPageScreen> createState() => _MoreOrdersPageScreenState();
}

class _MoreOrdersPageScreenState extends State<MoreOrdersPageScreen> {

  final MoreOrdersViewModel _moreOrdersViewModel = instance<MoreOrdersViewModel>();

  _bind(){
    _moreOrdersViewModel.start();
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
                if (snapshot.data != null && _moreOrdersViewModel.isOutStateLoading) {
                  _handleMoreOrdersStateChanged(snapshot.data!);
                }
                return _getMoreOrdersScreenContent();
              },
            ),
          ),
        ));
  }

  Widget _getMoreOrdersScreenContent() {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
              color: ColorManager.colorRedB2,
              onRefresh: () async {
             _moreOrdersViewModel.getRecentOrders(); // Assuming a method to refresh data exists
          },
          child: StreamBuilder<ModelOrdersResponseRemote>(
            stream: _moreOrdersViewModel.outputOrdersData,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data?.data?.isNotEmpty == true) {
                return ListView.builder(
                  itemCount: snapshot.data?.data?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppPadding.p8, horizontal: AppPadding.p16),
                      child: ServiceRequestCard(orders: snapshot.data!.data![index]),
                    );
                  },
                );
              }
              // else if (snapshot.connectionState == ConnectionState.waiting) {
              //   return const Center(child: CircularProgressIndicator());
              // }
              else {
                return Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p100),
                  child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageAssets.ordersIcon),
                          Text(
                            "No Orders Found",
                            style: getRegularStyle(
                                color: ColorManager.black, fontSize: FontSize.size16),
                          ),
                        ],
                      )
                  ),
                );
              }
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

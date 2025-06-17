import 'package:beauty_car/home/presentation/homePageScreen/viewmodel/home_viewmodel.dart';
import 'package:beauty_car/home/presentation/routeManager/home_routes_manager.dart';
import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/fontManager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/styleManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../../utils/loading_page.dart';
import '../../../data/response/orders/orders.dart';
import '../../homeSharedViews/home_center_outside_services.dart';
import '../../homeSharedViews/home_complete_service.dart';
import '../../homeSharedViews/home_page_app_bar.dart';
import '../../homeSharedViews/service_request_card.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  final HomeViewModel _homeViewModel = instance<HomeViewModel>();

  _bind() {
    _homeViewModel.start();
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
          body: SafeArea(
              child:
              StreamBuilder<FlowState>(
                stream: _homeViewModel.outputState,
                builder: (context, snapshot) {
                  if (snapshot.data != null && _homeViewModel.isOutStateLoading) {
                    _handleHomeStateChanged(snapshot.data!);
                  }
                  return _getHomeScreenContent();
                },
              )
              ),
        ));
  }

  Widget _getHomeScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        HomePageAppBar(),
        Expanded(
          child: RefreshIndicator(
            color: ColorManager.colorRedB2,
            onRefresh: () async {
              await _homeViewModel.getRecentOrders(); // Assuming a method to refresh data exists
            },
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                  HomeCompleteService(),
                  const SizedBox(height: AppSize.s13),
                  HomeCenterOutsideServices(),
                  const SizedBox(height: AppSize.s13),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppStrings.serviceRequests.tr(),
                            style: getBoldStyle(
                                color: ColorManager.black, fontSize: FontSize.size16)),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, HomeRoutes.moreOrdersRoute);
                          },
                          child: Text(AppStrings.more.tr(),
                              style: getRegularStyle(
                                  color: ColorManager.colorRedB2,
                                  fontSize: FontSize.size16)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSize.s8),
                  StreamBuilder<ModelOrdersResponseRemote>(
                    stream: _homeViewModel.outputOrdersData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data?.data?.isNotEmpty == true) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
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
                          padding: const EdgeInsets.only(top: AppPadding.p70),
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
                ],
            ),
          ),
        ),
      ],
    );
  }

  _handleHomeStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _homeViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _homeViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }
}

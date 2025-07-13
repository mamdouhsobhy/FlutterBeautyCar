import 'package:beauty_car/app/sharedPrefs/app_prefs.dart';
import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:beauty_car/home/data/response/getHomeStatistics/get_home_statistics.dart';
import 'package:beauty_car/home/presentation/homePageScreen/view/side_menu.dart';
import 'package:beauty_car/home/presentation/homePageScreen/view/side_menu_employee.dart';
import 'package:beauty_car/home/presentation/homePageScreen/viewmodel/home_viewmodel.dart';
import 'package:beauty_car/home/presentation/routeManager/home_routes_manager.dart';
import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/fontManager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:beauty_car/utils/Constants.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../firebase/firebase_api.dart';
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
  final Function(int) sideMenuTabsPressed;
  const HomePageScreen({super.key,required this.sideMenuTabsPressed});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  final _firebaseMessaging = FirebaseMessaging.instance;
  final HomeViewModel _homeViewModel = instance<HomeViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  ModelLoginResponseRemote? userDate;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? fCMToken = "";

  _bind() async {
    _homeViewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
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

  @override
  void didChangeDependencies() async{
    if(userDate == null) {
      userDate = await _appPreferences.getUserData();
      fCMToken = await _firebaseMessaging.getToken();
      print("FCM Token: $fCMToken");
      if (userDate?.data?.notificationStatus == 1) {
        _homeViewModel.updateNotify(
            "$fCMToken", "${_appPreferences.getUserType()}");
      }
    }


    Future.delayed(const Duration(milliseconds: 500), () {
      final orderId = FireBaseApi.pendingOrderId;
      if (orderId != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(
            context,
            HomeRoutes.reserveDetailsRoute,
            arguments: {'orderId': orderId},
          );
          FireBaseApi.pendingOrderId = null;
        });
      }
    });

    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: ColorManager.white,
          drawer: SafeArea(child: Drawer(child:
          "${_appPreferences.getUserType()}" == UserTypes.owner ? SideMenu(appPreferences: _appPreferences,fun: widget.sideMenuTabsPressed)
              : SideMenuEmployee(appPreferences: _appPreferences,fun: widget.sideMenuTabsPressed)
          )
          ),
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
        StreamBuilder<ModelGetHomeStatisticsResponseRemote>(
            stream: _homeViewModel.outputStatisticsData,
            builder: (context, snapshot) {
              return HomePageAppBar(scafoldKey: _scaffoldKey, unReadNotify:"${(snapshot.data?.data?.unread_notifications_count ?? 0)}");
            }),
        Expanded(
          child: RefreshIndicator(
            color: ColorManager.colorRedB2,
            onRefresh: () async {
              await _homeViewModel.getRecentOrders(); // Assuming a method to refresh data exists
            },
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                StreamBuilder<ModelGetHomeStatisticsResponseRemote>(
                    stream: _homeViewModel.outputStatisticsData,
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          HomeCompleteService(
                              completedService:
                                  "${(snapshot.data?.data?.outdoorOrders ?? 0) + (snapshot.data?.data?.shopOrders ?? 0)}"),
                          const SizedBox(height: AppSize.s13),
                          const SizedBox(height: AppSize.s13),
                          HomeCenterOutsideServices(outDoorService: "${(snapshot.data?.data?.outdoorOrders ?? 0)}",
                          shopService: "${(snapshot.data?.data?.shopOrders ?? 0)}"),
                        ],
                      );
                    }),
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
                              child: ServiceRequestCard(orders: snapshot.data!.data![index],fun: (orderId){
                                _navigateToOrderDetails("$orderId");
                              }),
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

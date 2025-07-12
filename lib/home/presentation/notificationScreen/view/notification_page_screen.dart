import 'package:beauty_car/home/data/response/getNotification/get_notification.dart';
import 'package:beauty_car/home/presentation/notificationScreen/viewmodel/notification_viewmodel.dart';
import 'package:beauty_car/home/presentation/notificationScreen/widget/notification_item_card.dart';
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
import '../../routeManager/home_routes_manager.dart';

class NotificationPageScreen extends StatefulWidget {
  const NotificationPageScreen({super.key});

  @override
  State<NotificationPageScreen> createState() => _NotificationPageScreenState();
}

class _NotificationPageScreenState extends State<NotificationPageScreen> {
  final NotificationViewModel _notificationViewModel = instance<NotificationViewModel>();
  final ScrollController _scrollController = ScrollController();

  List<NotifyData> filteredNotification = [];

  _bind() {
    _notificationViewModel.start();
  }


  void _refreshNotification() {
    _notificationViewModel.notifyData.add(ModelGetNotificationResponseRemote());
    _notificationViewModel.resetPage();
    _notificationViewModel.notificationList.clear();
    filteredNotification.clear();
    _notificationViewModel.getNotification();
  }

  @override
  void initState() {
    _bind();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        _notificationViewModel.page++ ;
        _notificationViewModel.getNotification();
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
          appBar: MyAppBar(title: AppStrings.notification.tr()),
          body: SafeArea(
            child: StreamBuilder<FlowState>(
              stream: _notificationViewModel.outputState,
              builder: (context, snapshot) {
                if (snapshot.data != null && _notificationViewModel.isOutStateLoading) {
                  _handleNotifyStateChanged(snapshot.data!);
                }
                return _getNotificationScreenContent();
              },
            ),
          ),
        ));
  }

  Widget _getNotificationScreenContent() {
    return StreamBuilder<ModelGetNotificationResponseRemote>(
        stream: _notificationViewModel.outputNotifyData,
        builder: (context, notifications) {
          return Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _refreshNotification();
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Container(
                        height: constraints.maxHeight,
                        child: StreamBuilder<ModelGetNotificationResponseRemote>(
                          stream: _notificationViewModel.outputNotifyData,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data?.data?.data?.isNotEmpty == true) {
                              for (var notify in snapshot.data!.data!.data!) {
                                if (!_notificationViewModel.notificationList.contains(notify)) {
                                  _notificationViewModel.notificationList.add(notify);
                                }
                              }
                            }

                            if (_notificationViewModel.notificationList.isEmpty) {
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
                                          "No Notification Found",
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
                              filteredNotification = _notificationViewModel.notificationList;
                              // }
                              print("ListSize ${filteredNotification.length}");
                              return ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                                child: ListView.builder(
                                  controller: _scrollController,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemCount: filteredNotification.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: AppPadding.p8,
                                          horizontal: AppPadding.p16),
                                      child: NotificationItemCard(notification: filteredNotification[index],fun: (orderId){
                                        Future.delayed(const Duration(milliseconds: 500), () {
                                          Navigator.pushNamed(
                                            context,
                                            HomeRoutes.reserveDetailsRoute,
                                            arguments: {'orderId': "$orderId"},
                                          );
                                        });
                                      }),
                                    );
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
          );
        });
  }

  _handleNotifyStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _notificationViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _notificationViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _notificationViewModel.dispose();
    super.dispose();
  }

}

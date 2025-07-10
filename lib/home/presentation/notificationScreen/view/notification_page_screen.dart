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

class NotificationPageScreen extends StatefulWidget {
  const NotificationPageScreen({super.key});

  @override
  State<NotificationPageScreen> createState() => _NotificationPageScreenState();
}

class _NotificationPageScreenState extends State<NotificationPageScreen> {
  final NotificationViewModel _notificationViewModel = instance<NotificationViewModel>();
  
  List<Data> filteredNotification = [];

  _bind() {
    _notificationViewModel.start();
  }


  void _refreshEmployees() {
    _notificationViewModel.notifyData.add(ModelGetNotificationResponseRemote());
    _notificationViewModel.resetPage();
    _notificationViewModel.notificationList.clear();
    filteredNotification.clear();
    _notificationViewModel.getNotification();
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
          return RefreshIndicator(
            onRefresh: () async {
              _refreshEmployees();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: AppPadding.p8,),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notifications.data?.data?.data?.length ?? 0,
                    separatorBuilder: (context, index) =>
                        Divider(
                          height: AppSize.s1,
                          color: ColorManager.white,
                        ),
                    itemBuilder: (context, index) {
                      var item  = notifications.data?.data?.data![index];
                      return NotificationItemCard(notification: item!);
                    },
                  ),
                  const SizedBox(height: AppPadding.p8,),
                ],
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

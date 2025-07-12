import 'dart:async';
import 'package:beauty_car/home/data/response/getNotification/get_notification.dart';
import 'package:beauty_car/home/domain/usecase/notification_usecase.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../domain/usecase/employee_usecase.dart';

class NotificationViewModel extends BaseViewModel implements NotificationViewModelInputs,NotificationViewModelOutputs{

  final StreamController _notificationStreamController = BehaviorSubject<ModelGetNotificationResponseRemote>();

  final NotificationUseCase _notificationUseCase;

  NotificationViewModel(this._notificationUseCase);

  List<NotifyData> notificationList = [];

  int page = 1;

  //inputs
  @override
  void dispose() {
     super.dispose();
     _notificationStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
    getNotification();
  }

  @override
  void resetPage() {
    page = 1;
    notificationList.clear();
  }

  @override
  Sink get notifyData => _notificationStreamController.sink;

   var isNotificationLoading = false;
   var isOutStateLoading = false;

  Future<void> getNotification() async {
    isNotificationLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _notificationUseCase.execute(page))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isNotificationLoading = true;
      notifyData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  //outputs
  @override
  Stream<ModelGetNotificationResponseRemote> get outputNotifyData => _notificationStreamController.stream.map((data) => data);

  @override
   bool isShowError = false;


}

abstract class NotificationViewModelInputs{
   Sink get notifyData;
   void resetPage();
}

abstract class NotificationViewModelOutputs{
  Stream<ModelGetNotificationResponseRemote> get outputNotifyData;
}

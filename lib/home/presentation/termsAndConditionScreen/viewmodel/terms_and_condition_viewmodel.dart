import 'dart:async';
import 'package:beauty_car/home/data/response/getSettings/get_settings.dart';
import 'package:beauty_car/home/domain/usecase/settings_usecase.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';

class TermsAndConditionViewModel extends BaseViewModel implements TermsAndConditionViewModelInputs,TermsAndConditionViewModelOutputs{

  final StreamController _settingsStreamController = BehaviorSubject<ModelGetSettingsResponseRemote>();

  final SettingsUseCase _settingsUseCase;

  TermsAndConditionViewModel(this._settingsUseCase);

  //inputs
  @override
  void dispose() {
     super.dispose();
     _settingsStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
    getSettings();
  }


  @override
  Sink get settingsData => _settingsStreamController.sink;

  var isSettingsLoading = false;
  var isOutStateLoading = false;

  Future<void> getSettings() async {
    isSettingsLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _settingsUseCase.execute(""))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isSettingsLoading = true;
      settingsData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  //outputs
  @override
  Stream<ModelGetSettingsResponseRemote> get outputSettingsData => _settingsStreamController.stream.map((data) => data);

  @override
   bool isShowError = false;


}

abstract class TermsAndConditionViewModelInputs{
   Sink get settingsData;
}

abstract class TermsAndConditionViewModelOutputs{
  Stream<ModelGetSettingsResponseRemote> get outputSettingsData;
}

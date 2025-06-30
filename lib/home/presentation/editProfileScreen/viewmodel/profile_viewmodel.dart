
import 'dart:async';
import 'dart:io';
import 'package:beauty_car/home/domain/usecase/profile_usecase.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../authentication/data/response/login/login.dart';
import '../../../../utils/Constants.dart';

class ProfileViewModel extends BaseViewModel implements ProfileViewModelInputs,ProfileViewModelOutputs{

  final StreamController _updateProfileStreamController = BehaviorSubject<ModelLoginResponseRemote>();

  final ProfileUseCase _profileUseCase;

  ProfileViewModel(this._profileUseCase);

  //inputs
  @override
  void dispose() {
     super.dispose();
     _updateProfileStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get updateProfileData => _updateProfileStreamController.sink;

   var isUpdateLoading = false;
   var isOutStateLoading = false;

  Future<void> updateProfile(String name,File? image) async {
    isUpdateLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _profileUseCase.execute(await buildUpdateProfileFormData(name,image)))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isUpdateLoading = true;
      updateProfileData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<FormData> buildUpdateProfileFormData(String name, File? image) async {
    final formData = FormData();
    formData.fields.addAll([
      MapEntry("name", name),
      const MapEntry("type", UserTypes.owner)
    ]);

    if(image != null) {
      formData.files.add(MapEntry(
        "image",
        await MultipartFile.fromFile(image.path),
      ));
    }

    return formData;
  }

  //outputs
  @override
  Stream<ModelLoginResponseRemote> get outputUpdateProfileData => _updateProfileStreamController.stream.map((data) => data);

   @override
   bool isShowError = false;


}

abstract class ProfileViewModelInputs{
   Sink get updateProfileData;
}

abstract class ProfileViewModelOutputs{
  Stream<ModelLoginResponseRemote> get outputUpdateProfileData;
}

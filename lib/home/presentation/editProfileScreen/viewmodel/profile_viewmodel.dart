
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

  String type = "";

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

  Future<void> updateProfile(String name,File? image,String startTime , String endTime,String phone,String email) async {
    isUpdateLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _profileUseCase.execute(await buildUpdateProfileFormData(name,image,startTime,endTime,phone,email)))
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

  Future<FormData> buildUpdateProfileFormData(
      String name, File? image,String startTime , String endTime,String phone,String email
      ) async {
    final formData = FormData();
    formData.fields.addAll([
      MapEntry("name", name),
      MapEntry("type", type)
    ]);

    if(type == "2"){
      formData.fields.addAll([
        MapEntry("start_time", startTime),
        MapEntry("end_time", endTime)
      ]);
    }

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

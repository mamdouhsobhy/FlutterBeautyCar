
import 'dart:async';
import 'package:beauty_car/home/data/request/centers_request.dart';
import 'package:beauty_car/home/data/response/centers/centers.dart';
import 'package:beauty_car/home/domain/usecase/centers_usecase.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';

class CentersViewModel extends BaseViewModel implements CentersViewModelInputs,CentersViewModelOutputs{

  final StreamController _centersStreamController = BehaviorSubject<ModelCentersResponseRemote>();

  final CentersUseCase _centersUseCase;

  final centerRequest = CentersRequest(true , 6 , 1);

  int page = 1;
  List<Data> centersList = [];

  CentersViewModel(this._centersUseCase);

  //inputs
  @override
  void dispose() {
     super.dispose();
     _centersStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
    getCenters();
  }

  @override
  Sink get centersData => _centersStreamController.sink;

   var isCentersLoading = false;
   var isOutStateLoading = false;

  Future<void> getCenters() async {
    isCentersLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _centersUseCase.execute(CentersRequest(centerRequest.pagination, centerRequest.limit, centerRequest.page)))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isCentersLoading = true;
      centersData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  //outputs
  @override
  Stream<ModelCentersResponseRemote> get outputCentersData => _centersStreamController.stream.map((data) => data);

   @override
   bool isShowError = false;


}

abstract class CentersViewModelInputs{
   Sink get centersData;
}

abstract class CentersViewModelOutputs{
  Stream<ModelCentersResponseRemote> get outputCentersData;
}

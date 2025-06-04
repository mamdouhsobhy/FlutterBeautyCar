import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel
    implements BaseViewModelInputs, BaseViewModelOutputs {

  final StreamController _inputStreamController = BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _inputStreamController.sink;
  
  @override
  Stream<FlowState> get outputState => _inputStreamController.stream.map((flowState) => flowState);
  
  @override
  void dispose() {
    _inputStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start();

  void dispose();

  bool isShowError = false;

  Sink get inputState;
}

abstract class BaseViewModelOutputs {

  Stream<FlowState> get outputState;
}

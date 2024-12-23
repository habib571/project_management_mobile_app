import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import '../stateRender/state_render_impl.dart';

abstract class BaseViewModel extends  ChangeNotifier implements BaseViewModelInputs ,
     BaseViewModelOutputs {
  late Stream<FlowState> _stateStream;
  final stateController = StreamController<FlowState>();
  BaseViewModel() {
    _stateStream = stateController.stream.asBroadcastStream();
  }

  @override
  Stream<FlowState> get outputState => _stateStream;

  @override
  void dispose() {
    super.dispose();
    stateController.close();
  }

  @override
  void start() {
    _stateStream = stateController.stream.asBroadcastStream();
  }

  @override
  void updateState(FlowState state) {
    stateController.add(state);
  }
}

abstract class BaseViewModelInputs {
  void start();

  void dispose();

  void updateState(FlowState state);
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/services/token_mamanger.dart';
import '../stateRender/state_render_impl.dart';

abstract class BaseViewModel extends ChangeNotifier
    implements BaseViewModelInputs , BaseViewModelOutputs {

  late Stream<FlowState> _stateStream;
  final stateController = StreamController<FlowState>();
  late final TokenManager _tokenManager;

  BaseViewModel(/*this._tokenManager*/) {
    _stateStream = stateController.stream.asBroadcastStream();
  }

  @override
  Stream<FlowState> get outputState => _stateStream;

  @override
  void dispose() {
    stateController.close();
  }

  @override
  void start() {
    _stateStream = stateController.stream.asBroadcastStream();
    startTokenMonitoring();
  }

  @override
  void updateState(FlowState state) {
    stateController.add(state);
  }

  void startTokenMonitoring(){
    _tokenManager.startTokenMonitoring();
    _tokenManager.tokenValidityStream.listen((isTokenValid){
      if(!isTokenValid){
       // updateState(state);  update to token expired state
      }
    });
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

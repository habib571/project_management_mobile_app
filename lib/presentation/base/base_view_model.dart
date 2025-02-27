import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rxdart/rxdart.dart';

import '../../application/helpers/get_storage.dart';
import '../../application/navigation/routes_constants.dart';
import '../../application/helpers/token_mamanger.dart';
import '../stateRender/state_render.dart';
import '../stateRender/state_render_impl.dart';

abstract class BaseViewModel extends  ChangeNotifier implements BaseViewModelInputs ,
     BaseViewModelOutputs {
  late Stream<FlowState> _stateStream;
  final stateController = StreamController<FlowState>.broadcast();
  final TokenManager _tokenManager;
  bool startTokenMonitoringOnInit;

  BaseViewModel(this._tokenManager,{this.startTokenMonitoringOnInit = true}) {
    _stateStream = stateController.stream.asBroadcastStream() ;
    if (startTokenMonitoringOnInit) {
      startTokenMonitoring();
    }
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
    _stateStream = stateController.stream;
  }

  @override
  void updateState(FlowState state) {
    stateController.add(state);
  }

  void startTokenMonitoring(){
    _tokenManager.startTokenMonitoring();
    _tokenManager.tokenValidityStream.listen((isTokenValid){
      if(!isTokenValid){
         updateState(ErrorState(StateRendererType.snackbarState, "Session expired"),);
        Get.offAllNamed(AppRoutes.login) ;
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

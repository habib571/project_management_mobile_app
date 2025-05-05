import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../application/navigation/routes_constants.dart';
import '../../application/helpers/token_mamanger.dart';
import '../stateRender/state_render.dart';
import '../stateRender/state_render_impl.dart';

abstract class BaseViewModel extends ChangeNotifier implements BaseViewModelInputs, BaseViewModelOutputs {
  // Use BehaviorSubject to cache the latest emitted FlowState.
  final BehaviorSubject<FlowState> _stateSubject = BehaviorSubject<FlowState>();
  final TokenManager _tokenManager;
  bool startTokenMonitoringOnInit;

  BaseViewModel(this._tokenManager, {this.startTokenMonitoringOnInit = true}) {
    if (startTokenMonitoringOnInit) {
      startTokenMonitoring();
    }
  }

  @override
  Stream<FlowState> get outputState => _stateSubject.stream;

  @override
  void updateState(FlowState state) {
    _stateSubject.add(state);
  }

  @override
  void dispose() {
    _stateSubject.close();
    super.dispose();
  }

  @override
  void start() {
    // Emit an initial state.
    updateState(ContentState());
  }

  void startTokenMonitoring() {
    _tokenManager.startTokenMonitoring();
    _tokenManager.tokenValidityStream.listen((isTokenValid) {
      if (!isTokenValid) {
        updateState(ErrorState(StateRendererType.snackbarState, "Session expired"));
        Get.offAllNamed(AppRoutes.login);
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

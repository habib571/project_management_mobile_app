

import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/cupertino.dart';

import '../stateRender/state_render_impl.dart';

abstract class BaseViewModel extends ChangeNotifier {
  void start();
  final StreamController _inputStreamController =
  BehaviorSubject<FlowState>();
  Stream<FlowState> get outputState => _inputStreamController.stream.map((flowState) => flowState);
  Sink get inputState => _inputStreamController.sink;


}
import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:project_management_app/application/constants/constants.dart';


class TokenManager {
  //final AuthService _authService; // Service responsable de gérer le token
  final StreamController<bool> _tokenValidityController = StreamController<bool>.broadcast();
  Timer? _timer;

  final GetStorage _getStorage;
  TokenManager(this._getStorage);

  Stream<bool> get tokenValidityStream => _tokenValidityController.stream;

  void startTokenMonitoring() {
    _checkTokenValidity();
    _timer = Timer.periodic(Duration(seconds: 10), (_) {
      _checkTokenValidity();
    });
  }

  void stopTokenMonitoring() {
    _timer?.cancel();
    _tokenValidityController.close();
  }

  DateTime getTokenExpiry(){
    DateTime createdtAtDate = DateTime.parse(_getStorage.read('logedInAt')) ;
    Duration expiresIn =    Duration(milliseconds: _getStorage.read('expiresIn'));
    DateTime epireDate = createdtAtDate.add(expiresIn);
    return epireDate;
  }

  Future<void> _checkTokenValidity() async {
    final expiryDate = getTokenExpiry();
    final isTokenValid = expiryDate.isAfter(DateTime.now());
    _tokenValidityController.add(isTokenValid);
  }
}

import 'dart:async';

import 'package:project_management_app/application/constants/constants.dart';

class TokenManager {
  //final AuthService _authService; // Service responsable de gérer le token
  final StreamController<bool> _tokenValidityController = StreamController<bool>.broadcast();
  Timer? _timer;

  //TokenManager(this._authService);

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
    DateTime createdtAtDate =  DateTime.parse(Constants.createdAt);
    Duration expiresIn = Duration(milliseconds: Constants.expiresIn);
    DateTime epireDate = createdtAtDate.add(expiresIn);
    return epireDate;
  }

  Future<void> _checkTokenValidity() async {
    final expiryDate = getTokenExpiry();
    final isTokenValid = expiryDate.isAfter(DateTime.now());
    _tokenValidityController.add(isTokenValid);
  }
}

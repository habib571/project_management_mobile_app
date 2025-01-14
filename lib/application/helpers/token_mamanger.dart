import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_management_app/application/constants/constants.dart';

import '../../data/responses/auth_response.dart';


class TokenManager {

  final StreamController<bool> _tokenValidityController = StreamController<bool>.broadcast();
  Timer? _timer;

  final GetStorage _getStorage;
  TokenManager(this._getStorage);

  Stream<bool> get tokenValidityStream => _tokenValidityController.stream;

  void startTokenMonitoring() {
    _checkTokenValidity();
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      _checkTokenValidity();
    });
  }

  void stopTokenMonitoring() {
    _timer?.cancel();
    _tokenValidityController.close();
  }

  DateTime getTokenExpiry(){
    DateTime createdtAtDate = DateTime.parse(_getStorage.read('logedInAt') ) ;
    AuthResponse userDetails = AuthResponse.fromJson(_getStorage.read('userDetails'));
    Duration expiresIn =  Duration(milliseconds: userDetails.expiresIn );
    DateTime epireDate = createdtAtDate.add(expiresIn);
    return epireDate;
  }

  Future<void> _checkTokenValidity() async {
    final expiryDate = getTokenExpiry();
    final isTokenValid = expiryDate.isAfter(DateTime.now());
    _tokenValidityController.add(isTokenValid);
  }

  Future<void> clearUserDetails()async{
    Future.wait([
      _getStorage.remove('userDetails'),
    ]);
  }

}

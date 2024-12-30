import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_management_app/application/helpers/token_mamanger.dart';

import '../constants/constants.dart';

abstract class LocalStorage {
  Future<void> saveAuthToken(String token,int expiresIn);
  Future<void> clearAuthToken();
  String? getAuthToken();
  bool get isUserLoggedIn;
}

class LocalStorageImp implements LocalStorage {
  final GetStorage _getStorage;
  final TokenManager _tokenManager;

  LocalStorageImp(this._getStorage,this._tokenManager);

  @override
  Future<void> saveAuthToken(String token,int expiresIn) async {
     _tokenManager.saveTokenRelatedProprities(token, expiresIn);
  }

  @override
  String? getAuthToken() {
    return _getStorage.read('Token');
  }

  @override
  Future<void> clearAuthToken() async {
    await _tokenManager.clearAuthTokenProprities();
  }

  bool isUserLogged() {
    return _getStorage.hasData('Token') &&  _tokenManager.getTokenExpiry().isAfter(DateTime.now()) ;
  }


  @override
  bool get isUserLoggedIn => isUserLogged();
}
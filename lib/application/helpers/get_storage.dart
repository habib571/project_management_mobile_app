import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_management_app/application/helpers/token_mamanger.dart';

import '../constants/constants.dart';

abstract class LocalStorage {
  Future<void> saveAuthToken(String token,int expiresIn);
  Future<void> clearAuthToken();
  bool get isUserLoggedIn;
}

class LocalStorageImp implements LocalStorage {
  final GetStorage _getStorage;
  final TokenManager _tokenManager;

  LocalStorageImp(this._getStorage,this._tokenManager);

  @override
  Future<void> saveAuthToken(String token,int expiresIn) async {
    Future.wait(_tokenManager.saveTokenRelatedProprities(token, expiresIn).entries.map((entry)=>_getStorage.write(entry.key, entry.value))
    );
  }

  String? getAuthToken() {
    return _getStorage.read(Constants.authToken);
  }

  @override
  Future<void> clearAuthToken() async {
    Future.wait([
     _getStorage.remove('Token'),
     _getStorage.remove('logedInAt'),
     ]
    );
  }

  bool isUserLogged() {
    return _getStorage.hasData('Token') &&  _tokenManager.getTokenExpiry().isAfter(DateTime.now()) ;
  }


  @override
  bool get isUserLoggedIn => isUserLogged();
}
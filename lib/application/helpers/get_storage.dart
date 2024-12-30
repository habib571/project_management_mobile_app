import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';

abstract class LocalStorage {
  Future<void> saveAuthToken(String token);
  Future<void> clearAuthToken();
  bool get isUserLoggedIn;
}

class LocalStorageImp implements LocalStorage {
  final GetStorage _getStorage;

  LocalStorageImp(this._getStorage);

  @override
  Future<void> saveAuthToken(String token) async {
    await _getStorage.write('Token', token);
  }

  String? getAuthToken() {
    return _getStorage.read(Constants.authToken);
  }

  @override
  Future<void> clearAuthToken() async {
    await _getStorage.remove('Token');
  }

  bool isUserLogged() {
    return _getStorage.hasData('Token');
  }

  @override
  bool get isUserLoggedIn => isUserLogged();
}
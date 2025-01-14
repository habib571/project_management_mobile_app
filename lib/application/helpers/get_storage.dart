import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_management_app/application/helpers/token_mamanger.dart';
import 'package:project_management_app/data/responses/auth_response.dart';

import '../../domain/models/user.dart';
import '../constants/constants.dart';

abstract class LocalStorage {
  Future<void> saveUserDetail(AuthResponse userDetails);
  String? getAuthToken();
  bool get isUserLoggedIn;
}

class LocalStorageImp implements LocalStorage {
  final GetStorage _getStorage;
  final TokenManager _tokenManager;


  LocalStorageImp(this._getStorage,this._tokenManager);

  @override
  Future<void> saveUserDetail(AuthResponse userDetails) async {
      _getStorage.write("logedInAt", DateTime.now().toIso8601String());
      _getStorage.write("userDetails", userDetails.toJson() );
  }

  @override
  String? getAuthToken() {
    AuthResponse userDetails = AuthResponse.fromJson(_getStorage.read('userDetails'))   ;
    return userDetails.token ;
  }

  bool isUserLogged() {
    return _getStorage.hasData('userDetails') &&  _tokenManager.getTokenExpiry().isAfter(DateTime.now()) ;
  }

  @override
  bool get isUserLoggedIn => isUserLogged();
}
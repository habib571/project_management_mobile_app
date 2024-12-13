import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import '../../../application/constants/constants.dart';
import '../remoteDataSource/auth_remote_data_source.dart';



abstract class AuthLocalDataSource {
  Future<void> saveAuthToken(String token , DateTime createdAt ,int expiresIn);
  String? getAuthToken();
}

class AuthLocalDataSourceImp implements AuthLocalDataSource {

  final storage = GetIt.instance<GetStorage>();

  @override
  Future<void> saveAuthToken (String token , DateTime createdAt ,int expiresIn) async {
    await storage.write(Constants.authToken, token) ;
    await storage.write(Constants.expiresIn.toString(), expiresIn);
    await storage.write(Constants.createdAt, createdAt.toIso8601String());
  }
  String? getAuthToken() {
    print("*********  ${storage.read(Constants.authToken)} **********");
    print("*********  ${storage.read(Constants.expiresIn.toString())} **********");
    print("*********  ${storage.read( Constants.createdAt)} **********");
    return storage.read(Constants.authToken);
  }
  //SignOut
  Future<void> clearAuthToken() async {
    await storage.remove(Constants.authToken);
  }

  bool isUserLoggedIn() {
    return storage.hasData(Constants.authToken);
  }



  
}
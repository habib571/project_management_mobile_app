import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management_app/application/functions/cruds_functions.dart';
import 'package:project_management_app/data/network/requests/auth_requests.dart';
import 'package:project_management_app/data/responses/api_response.dart';
import 'package:project_management_app/data/responses/auth_response.dart';

import '../../../application/helpers/get_storage.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResponse> signup(RegisterRequest request);
  Future<ApiResponse> sigIn(SignInRequest request);
  Future<ApiResponse> getCurrentUserInfo();
  Future<ApiResponse> logOut();
  Future<ApiResponse> updateProfileImage(XFile image);

}
//
class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final LocalStorage _localStorage ;

  AuthRemoteDataSourceImp(this._localStorage);
  @override
  Future<ApiResponse> signup(RegisterRequest request) async {
    return await executePostRequest(
        apiUrl: "/auth/signup",
        body: request.toJson(),
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response, statusCode);
        });
  }

  @override
  Future<ApiResponse> sigIn(SignInRequest request) async{
    return await executePostRequest(
        apiUrl: "/auth/login",
        body: request.toJson(),
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response, statusCode);
        });
  }
  @override
  Future<ApiResponse> getCurrentUserInfo()async{
    return await executeGetRequest(
        apiUrl: "/users/me",
        bearerToken:  _localStorage.getAuthToken() ,
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response , statusCode);
        });
  }

  @override
  Future<ApiResponse> updateProfileImage(XFile image)async{
    return await executePutImageRequest(
        apiUrl: "/users/me/image",
        imageFile: image,
        bearerToken:  _localStorage.getAuthToken() ,
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response , statusCode);
        }, );
  }

  @override
  Future<ApiResponse> logOut() async{
    return await executePostRequest(
        apiUrl: "/auth/logout",
        bearerToken: _localStorage.getAuthToken(),
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response, statusCode);
        });
  }

}


import 'package:http/http.dart';
import 'package:project_management_app/application/functions/cruds_functions.dart';
import 'package:project_management_app/data/network/requests/auth_requests.dart';
import 'package:project_management_app/data/responses/api_response.dart';
import 'package:project_management_app/data/responses/auth_response.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResponse> signup(RegisterRequest request);
  Future<ApiResponse> sigIn(SignInRequest request);
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
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
}

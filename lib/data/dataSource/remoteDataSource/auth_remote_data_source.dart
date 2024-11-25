import 'package:http/http.dart';
import 'package:project_management_app/application/functions/cruds_functions.dart';
import 'package:project_management_app/data/network/requests.dart';
import 'package:project_management_app/data/responses/api_response.dart';
import 'package:project_management_app/data/responses/auth_response.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResponse> signup(RegisterRequest request);
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
}
 import 'package:project_management_app/data/responses/api_response.dart';

import '../../../application/functions/cruds_functions.dart';
import '../../../application/helpers/get_storage.dart';
import '../../../domain/models/project.dart';



abstract class ProjectDataSource {
  Future<ApiResponse> addProject( Project request );
}

 class ProjectRemoteDataSource implements ProjectDataSource{
   final LocalStorage _localStorage ;

   ProjectRemoteDataSource(this._localStorage);

  @override
  Future<ApiResponse> addProject(Project request) async{
      return await executePostRequest(
          apiUrl: "/project/add_project",
          bearerToken:  _localStorage.getAuthToken() ,
          body: request.toJson(),
          onRequestResponse: (response, statusCode) {
            return ApiResponse(response, statusCode);
          });
    }
}


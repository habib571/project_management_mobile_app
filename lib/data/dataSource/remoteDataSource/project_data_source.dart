 import 'package:project_management_app/data/responses/api_response.dart';

import '../../../application/functions/cruds_functions.dart';
import '../../../domain/models/project.dart';



abstract class ProjectDataSource {
  Future<ApiResponse> addProject( Project request );
}


 class ProjectRemoteDataSource implements ProjectDataSource{

  @override
  Future<ApiResponse> addProject(Project request) async{
      return await executePostRequest(
          apiUrl: "",
          body: request.toJson(),
          onRequestResponse: (response, statusCode) {
            return ApiResponse(response, statusCode);
          });
    }
}


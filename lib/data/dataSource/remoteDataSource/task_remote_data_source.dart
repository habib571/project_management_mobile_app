import 'package:project_management_app/data/network/requests/pagination.dart';

import '../../../application/functions/cruds_functions.dart';
import '../../../application/helpers/get_storage.dart';
import '../../../domain/models/Task/task.dart';
import '../../responses/api_response.dart';

abstract class TaskRemoteDataSource {
  Future<ApiResponse> addTask(TaskModel task ,int projectId) ;
  Future<ApiResponse> getProjectTasks(int projectId ,Pagination pagination ) ;

}
class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final LocalStorage _localStorage ;
  TaskRemoteDataSourceImpl(this._localStorage);

  @override
  Future<ApiResponse> addTask(TaskModel request ,int projectId)async {
    return await executePostRequest(
        apiUrl: "/task/add-task/$projectId",
        bearerToken: _localStorage.getAuthToken() ,
        body: request.toJson(),
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response, statusCode);
        });
  }
  @override
  Future<ApiResponse> getProjectTasks(int projectId, Pagination pagination) async{
    return await executeGetRequest(
        apiUrl: "/task/project-tasks/$projectId?page=${pagination.page}&size=${pagination.size}",
        bearerToken: _localStorage.getAuthToken() ,
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response, statusCode);
        });

  }

}
import 'package:project_management_app/data/network/requests/filter_task_request.dart';
import 'package:project_management_app/data/network/requests/pagination.dart';

import '../../../application/functions/cruds_functions.dart';
import '../../../application/helpers/get_storage.dart';
import '../../../domain/models/Task/task.dart';
import '../../responses/api_response.dart';

abstract class TaskRemoteDataSource {
  Future<ApiResponse> addTask(TaskModel task ,int projectId) ;
  Future<ApiResponse> getProjectTasks(int projectId ,Pagination pagination ) ;

  Future<ApiResponse> searchTasks(String taskName , Pagination pagination) ;
  Future<ApiResponse> filterTasks(FilterTaskRequest filterRequest , Pagination pagination) ;

  Future<ApiResponse> updateTask(TaskModel request ,int taskId);

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

  @override

  Future<ApiResponse> searchTasks(String taskName, Pagination pagination) async{
    return await executeGetRequest(
        apiUrl: "/task/search?name=$taskName&page=${pagination.page}&size=${pagination.size}",
        bearerToken: _localStorage.getAuthToken() ,
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response, statusCode);
        });
  }

  @override
  Future<ApiResponse> filterTasks(FilterTaskRequest filterRequest, Pagination pagination) async {
    Map<String, String> queryParams = {};
    if (filterRequest.status != null && filterRequest.status!.isNotEmpty) {
      queryParams['status'] = filterRequest.status!;
    }
    if (filterRequest.priority != null && filterRequest.priority!.isNotEmpty) {
      queryParams['priority'] = filterRequest.priority!;
    }
    if (filterRequest.deadline != null && filterRequest.deadline!.isNotEmpty) {
      queryParams['deadline'] = filterRequest.deadline!;
    }
    queryParams['page'] = pagination.page.toString();
    queryParams['size'] = pagination.size.toString();

    final uri = Uri(
      path: '/task/filter',
      queryParameters: queryParams,
    );

    print(uri.toString());

    return await executeGetRequest(
      apiUrl: uri.toString(),
      bearerToken: _localStorage.getAuthToken(),
      onRequestResponse: (response, statusCode) {
        print(uri.toString());
        return ApiResponse(response, statusCode);
      },
    );
  }
  Future<ApiResponse> updateTask(TaskModel request ,int taskId)async {
    return await executePatchRequest(
        apiUrl: "/task/update/$taskId",
        bearerToken: _localStorage.getAuthToken() ,
        body: request.updateToJson(),
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response, statusCode);
        });

  }

}
import '../../../application/functions/cruds_functions.dart';
import '../../../application/helpers/get_storage.dart';
import '../../../domain/models/task.dart';
import '../../responses/api_response.dart';

abstract class TaskRemoteDataSource {
  Future<ApiResponse> addTask(TaskModel task ,int projectId) ;

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

}
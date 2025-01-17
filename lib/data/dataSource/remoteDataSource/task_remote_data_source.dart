import '../../../application/functions/cruds_functions.dart';
import '../../../application/helpers/get_storage.dart';
import '../../../domain/models/task.dart';
import '../../responses/api_response.dart';

abstract class TaskRemoteDataSource {
  Future<ApiResponse> addTask(TaskModel task) ;

}
class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final LocalStorage _localStorage ;
  TaskRemoteDataSourceImpl(this._localStorage);

  @override
  Future<ApiResponse> addTask(TaskModel request)async {
    return await executePostRequest(
        apiUrl: "/project/add_project",
        bearerToken: _localStorage.getAuthToken() ,
        body: request.toJson(),
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response, statusCode);
        });
  }

}
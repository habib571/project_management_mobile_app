 import 'package:project_management_app/data/responses/api_response.dart';

import '../../../application/functions/cruds_functions.dart';
import '../../../application/helpers/get_storage.dart';
import '../../../domain/models/project.dart';
import '../../network/requests/add_member_request.dart';
import '../../network/requests/report_issue_request.dart';



abstract class ProjectDataSource {
  Future<ApiResponse> addProject( Project request );
  Future<ApiResponse> getProjects() ;
  Future<ApiResponse> getProjectMember(int projectId) ;
  Future<ApiResponse> getMemberByName(String name ,int page , int size) ;
  Future<ApiResponse> addMember(AddMemberRequest request) ;
  Future<ApiResponse> reportIssue(ReportIssueRequest request) ;
  Future<ApiResponse> getAllIssues(int projectId) ;
  Future<ApiResponse> updateIssueStatus(int issueId) ;
}

 class ProjectRemoteDataSource implements ProjectDataSource{
   final LocalStorage _localStorage ;

   ProjectRemoteDataSource(this._localStorage);

  @override
  Future<ApiResponse> addProject(Project request) async{
      return await executePostRequest(
          apiUrl: "/project/add_project",
          bearerToken: _localStorage.getAuthToken() ,
          body: request.toJson(),
          onRequestResponse: (response, statusCode) {
            return ApiResponse(response, statusCode);
          });
    }

  @override
  Future<ApiResponse> getProjects() async{  
    return await executeGetRequest(
        apiUrl: "/project/my_projects",
        bearerToken:  _localStorage.getAuthToken() ,
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response as List<dynamic> , statusCode);
        });
  }

  @override
  Future<ApiResponse> getProjectMember(int projectId) async {
    return await executeGetRequest(
        apiUrl: "/project/members/$projectId",
        bearerToken: _localStorage.getAuthToken(),
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response , statusCode);
        });
  }

  @override
  Future<ApiResponse> getMemberByName(String name ,int page , int size ) async {
    return await executeGetRequest(
        apiUrl: "/users/$name?page=$page&size=$size",
        bearerToken:  _localStorage.getAuthToken() ,
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response as List<dynamic> , statusCode);
        });
  }

   @override
   Future<ApiResponse> addMember(AddMemberRequest request) async{
     return await executePostRequest(
         apiUrl: "/project/add_member",
         body: request.toJson(),
         bearerToken: _localStorage.getAuthToken(),
         onRequestResponse: (response, statusCode) {
           return ApiResponse(response, statusCode);
         });
   }

   @override
   Future<ApiResponse> reportIssue(ReportIssueRequest request) async{
     return await executePostRequest(
         apiUrl: "/issue/add-issue/${request.projectId}",
         body: request.toJson(),
         bearerToken: _localStorage.getAuthToken(),
         onRequestResponse: (response, statusCode) {
           return ApiResponse(response, statusCode);
         });
   }

   @override
   Future<ApiResponse> getAllIssues(int projectId) async {
     return await executeGetRequest(
         apiUrl: "/issue/get-all/$projectId",
         bearerToken:  _localStorage.getAuthToken() ,
         onRequestResponse: (response, statusCode) {
           return ApiResponse(response as List<dynamic> , statusCode);
         });
   }

   @override
   Future<ApiResponse> updateIssueStatus(int issueId) async{
     return await executePatchRequest(
         apiUrl: "/issue/mark-as-solved/$issueId",
         body: {},
         bearerToken: _localStorage.getAuthToken(),
         onRequestResponse: (response, statusCode) {
           return ApiResponse(response, statusCode);
         });
   }

}

import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/network/requests/report_issue_request.dart';
import 'package:project_management_app/data/responses/project_responce.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import '../../data/network/failure.dart';
import '../../data/network/requests/add_member_request.dart';
import '../models/issue.dart';
import '../models/project.dart';
import '../models/user.dart';

abstract class ProjectRepository {
  Future<Either<Failure, Project>> addProject(Project projectRequest);
  Future<Either<Failure, ProjectResponse>> getMyProjects();
  Future<Either<Failure, List<ProjectMember>>> getProjectMembers(int projectId) ;
  Future<Either<Failure, List<User>>> getMemberByName(String name ,int page , int size) ;
  Future<Either<Failure, ProjectMember>> addMember (AddMemberRequest addMemberRequest) ;
  Future<Either<Failure, Issue>> reportIssue (ReportIssueRequest reportIssueRequest) ;
  Future<Either<Failure, List<Issue>>> getAllIssues(int projectId) ;
  Future<Either<Failure, Issue>> updateIssueStatus (int issueId) ;
}
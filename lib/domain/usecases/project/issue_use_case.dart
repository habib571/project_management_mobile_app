import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/network/requests/report_issue_request.dart';
import 'package:project_management_app/domain/models/issue.dart';
import 'package:project_management_app/domain/repository/project_repo.dart';

import '../../../data/network/failure.dart';

class IssueUseCase {
  final ProjectRepository _projectRepository ;
  IssueUseCase(this._projectRepository);

  Future<Either<Failure, Issue>> reportIssue (ReportIssueRequest reportIssueRequest) async {
    return await _projectRepository.reportIssue(reportIssueRequest);
  }
  Future<Either<Failure, List<Issue>>> getAllIssues () async {
    return await _projectRepository.getAllIssues();
  }
}
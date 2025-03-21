import 'package:project_management_app/domain/models/project.dart';
import 'package:project_management_app/domain/models/Task/task.dart';

import '../../../domain/models/user.dart';

class ReportIssueRequest {
  String title ;
  String description ;
  int? memberId ;
  int? taskId ;
  int projectId ;

  ReportIssueRequest({
    required this.title ,
    required this.description ,
    required this.memberId ,
    required this.taskId ,
    required this.projectId
  });

  Map<String , dynamic> toJson(){
    return{
      'name': title ,
      'description': description ,
      'task_id': taskId ,
      'user_id': memberId ,
    };
  }

}
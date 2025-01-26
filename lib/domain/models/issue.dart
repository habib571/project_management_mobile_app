import 'package:project_management_app/domain/models/task.dart';
import 'package:project_management_app/domain/models/user.dart';

class Issue {
  int issueId ;
  String issueTitle ;
  String issueDescription ;
  User? taggedUser ;
  TaskModel ? taggedTask ;
  bool isSolved ;


  Issue(
     this.issueId ,
     this.issueTitle ,
     this.issueDescription ,
     this.taggedUser ,
     this.taggedTask ,
     this.isSolved ,
  );

  factory Issue.fromJson(Map<String , dynamic> json ){
    return Issue(
      json["id"],
      json["name"],
      json["description"],
      User.fromJson(json["tagedUserDto"]),
      TaskModel.fromJson(json['role']) ,
      json["solved"]
    );
  }

}


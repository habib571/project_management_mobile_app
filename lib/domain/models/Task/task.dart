import 'package:project_management_app/domain/models/project.dart';
import 'package:project_management_app/domain/models/user.dart';

class TaskModel {
  int? id;
  String? name;
  String? description;
  String? deadline;
  String? priority;
  String? status ;
  User? assignedUser;
  int? assignedUserId;
  Project? project ;

  TaskModel(this.id, this.name, this.description, this.deadline, this.priority, this.assignedUser ,this.status,this.project);
  TaskModel.request(this.name, this.description,this.deadline, this.priority ,this.assignedUserId, );
  TaskModel.taggedTask(this.id, this.name);
  TaskModel.taskToUpdate(this.id, this.name, this.description, this.deadline, this.priority, this.status,this.project ,this.assignedUser ,this.assignedUserId,);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      json['id'] ,
      json['title'] ,
      json['description'],
      json['deadline'] ,
      json['priority'] ,
      json['assignedUser'] != null ? User.fromJson(json['assignedUser']) : null ,
      json['status'],
      json['project' ]!= null ? Project.fromJson(json['project']) : null ,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'assignedTo': assignedUserId,
      'deadline': deadline,
      'priority': priority,
    };
  }

  Map<String, dynamic> updateToJson() {
    return {
      'name': name,
      'description': description,
      'assignedTo': assignedUserId,
      'deadline': deadline,
      'priority': priority,
      'status':status
    };
  }


  TaskModel copyWith({
    int? id,
    String? name,
    String? description,
    String? deadline,
    String? priority,
    User? assignedUser,
    String? status,
    int? assignedUserId,
    Project? project,
  }) {
    return TaskModel.taskToUpdate(
      id ?? this.id,
      name ?? this.name,
      description ?? this.description,
      deadline ?? this.deadline,
      priority ?? this.priority,
      status ?? this.status,
      project ?? this.project,
      assignedUser ?? this.assignedUser,
      assignedUserId ?? assignedUser?.id ,

    );
  }



}




import 'package:project_management_app/domain/models/user.dart';

class Task {
  int? id;
  String? name;
  String? description;
  String? deadline;
  String? priority;
  User? assignedUser;
  int? assignedUserId;

  Task(this.id, this.name, this.description, this.deadline, this.priority, this.assignedUser);


  Task.request(this.name, this.description, this.assignedUserId, this.deadline, this.priority);

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['id'] ,
      json['name'] ,
      json['description'],
      json['deadline'] ,
      json['priority'] ,
      json['assignedUser'] != null ? User.fromJson(json['assignedUser']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'assignedUserId': assignedUserId,
      'deadline': deadline,
      'priority': priority,
    };
  }
}
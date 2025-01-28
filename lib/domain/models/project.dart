import 'package:project_management_app/domain/models/user.dart';

class Project {
  int? id;
  String? name;
  String? description;
  String? startDate;
  String? endDate;
  double? progress;
  User? createdBy;

  Project(
      this.id,
      this.name,
      this.description,
      this.startDate,
      this.endDate,
      this.progress,
      this.createdBy,
      );
  Project.request(this.name, this.description, this.endDate);
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      json['id'],
      json['name'],
      json['description'],
      json['startDate'],
      json['endDate'],
      json['progress'] ,
      json['createdBy'] != null ? User.fromJson(json['createdBy']) : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'endDate': endDate,
    };
  }
}
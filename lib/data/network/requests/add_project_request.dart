
class AddProjectRequest {

  String projectName;
  String projectDescription;
  DateTime projectEndDate ;

  AddProjectRequest({required this.projectName,required this.projectDescription,required this.projectEndDate});

  Map<String, dynamic> toJson() {
    return {
      'projectName': projectName,
      'projectDescription': projectDescription,
      'projectEndDate': projectEndDate
    };
  }
}


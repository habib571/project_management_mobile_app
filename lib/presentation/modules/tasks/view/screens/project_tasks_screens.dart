import 'package:flutter/material.dart';
import 'package:project_management_app/domain/models/task.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task_widget.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';

class ProjectTasksScreens extends StatelessWidget {
  const ProjectTasksScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showBody()
    ) ;
  }
  Widget _showBody() {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical:25 ) ,
          child: Column(
            children: [ 
              CustomAppBar(title:"All Tasks" ) ,
              
            ],
          ),
      ),
    ) ;
  }

  Widget _showTaskList() {
     return ListView.builder(
         itemCount:  4,
         itemBuilder: (context, index) {
            return Container() ;
         }
     ) ;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/domain/models/task.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';

import '../../../../../application/helpers/get_storage.dart';
import '../../../../../domain/models/user.dart';
import '../../../../sharedwidgets/custom_issue_card.dart';
import '../../../../utils/colors.dart';

class IssuesScreen extends StatelessWidget{
  const IssuesScreen(  {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold ,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25.h,),
            const CustomAppBar(title: "All Issues"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 25.h,),
                  IssueCard(
                    currentUserId: 100 ,
                    title: 'API Bug',
                    description: '500 Error',
                    taskReference: TaskModel.taggedTask(12, "Task1"),
                    taggedUser: User(1, "ahmed", "ahmed@gmail.com", 'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
        
                    createdBy:User(1, "Nabil", "nabil@gmail.com", 'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
                    isResolved: true,
                    onMarkResolved: () {},
                  ),
                  IssueCard(
                    currentUserId: 100 ,
                    title: 'Error',
                    description: '500 Error',
                    taskReference: TaskModel.taggedTask(15, "Task5"),
                    taggedUser: null,
                    createdBy:User(1, "Nabil", "nabil@gmail.com", 'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
                    isResolved: true,
                    onMarkResolved: () {},
                  ),
                  IssueCard(
                    currentUserId: 202 ,
                    title: 'API Bug',
                    description: '500 Error',
                    taskReference: TaskModel.taggedTask(13, "Task2"),
                    taggedUser:  User(1, "mohamed", "ahmed@gmail.com", 'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
                    createdBy:User(202, "Nabil", "nabil@gmail.com", 'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
                    onMarkResolved: () {},
                  ),
                  IssueCard(
                    currentUserId: 202 ,
                    title: 'API Bug',
                    description: '500 Error',
                    taskReference: TaskModel.taggedTask(14, "Task3"),
                    taggedUser: User(1, "mohamed", "ahmed@gmail.com", 'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
                    createdBy:User(1, "Nabil", "nabil@gmail.com", 'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
                    onMarkResolved: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

}
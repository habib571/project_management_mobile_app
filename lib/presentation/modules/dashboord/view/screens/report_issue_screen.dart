import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/report_issue_viewmodel.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:project_management_app/presentation/sharedwidgets/input_text.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/presentation/utils/colors.dart';

import '../../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../sharedwidgets/custom_add_button.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../../../../sharedwidgets/custom_search_delegate.dart';
import '../../../../sharedwidgets/image_widget.dart';
import '../../../../utils/styles.dart';
import '../widgets/assigned_memberchip.dart';
import '../widgets/assigned_taskchip.dart';


class ReportIssueScreen extends StatelessWidget{
   ReportIssueScreen({super.key});

  final ReportIssueViewModel _viewModel = instance<ReportIssueViewModel>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: _showBody(context),
    );
  }


  Widget _showBody(BuildContext context) {
    return Form(
        key:_viewModel.formkey ,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              children: [
                SizedBox(height: 25.h,),
                const CustomAppBar(title: "Report issue"),
                SizedBox(height: 35.h,),
                _issueInputTextSection(),
                SizedBox(height: 35.h,),
                _issueDescriptionInputTextSection(),
                SizedBox(height: 35.h,),
                _membersChipSection(context),
                SizedBox(height: 35.h,),
                _tasksChipSection(context),
                SizedBox(height: 85.h,),
                _showButton()
              ],
            ),
          ),
    ));
  }



  Widget _issueInputTextSection(){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      controller: _viewModel.issueTitle,
      hintText: "Type the issue",
      prefixIcon: const Icon(Icons.report_problem_outlined),
      borderSide: const BorderSide(color: Colors.black),

    );
  }

  Widget _issueDescriptionInputTextSection(){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      controller: _viewModel.issueDescription,
      hintText: "Enter the issue description",
      maxLines: 3,
      prefixIcon: const Icon(Icons.description_outlined),
      borderRadius: 20,
      borderSide: const BorderSide(color: Colors.black),
    );
  }

  Widget _membersChipSection(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tag members", style: robotoBold.copyWith(fontSize: 18),),
        SizedBox(height: 10.h,),
        Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 8,
            spacing: 8,
            children: [
              AssignedMemberChip(imageUrl: 'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80', userName: "Ahmed", onDeleted: (){}),
              AssignedMemberChip(imageUrl: 'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80', userName: "Ahmed", onDeleted: (){}),
              AssignedMemberChip(imageUrl: 'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80', userName: "Ahmed", onDeleted: (){}),
              AssignedMemberChip(imageUrl: 'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80', userName: "Ahmed", onDeleted: (){}),
              CustomAddButton(onTap: (){
               // showSearch(context: context ,delegate: CustomSearchDelegate(_viewModel)
              },)
            ]
        ),
      ],
    );
  }

  Widget _tasksChipSection(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Mark a task", style: robotoBold.copyWith(fontSize: 18),),
        SizedBox(height: 10.h,),
        Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 8,
            spacing: 8,
            children: [
              AssignedTaskChip(taskName : "Task 1", onDeleted: (){}, ),
              AssignedTaskChip(taskName : "Task 2", onDeleted: (){}, ),
              AssignedTaskChip(taskName : "Task 3", onDeleted: (){}, ),
              AssignedTaskChip(taskName : "Task 4", onDeleted: (){}, ),
              CustomAddButton(onTap: (){},)
            ]
        ),
      ],
    );
  }

  Widget _showButton() {
    return CustomButton(
        onPressed: () {},
        text: 'Report issue');
  }
}




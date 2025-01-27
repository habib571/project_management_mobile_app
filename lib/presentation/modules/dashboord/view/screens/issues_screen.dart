import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/domain/models/task.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';

import '../../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../../application/helpers/get_storage.dart';
import '../../../../../domain/models/user.dart';
import '../../../../sharedwidgets/custom_issue_card.dart';
import '../../../../stateRender/state_render_impl.dart';
import '../../../../utils/colors.dart';
import '../../viewmodel/all_issues_view_model.dart';

class IssuesScreen extends StatefulWidget{
  const IssuesScreen(  {super.key});

  @override
  State<IssuesScreen> createState() => _IssuesScreenState();
}

class _IssuesScreenState extends State<IssuesScreen> {

  final GetAllIssuesViewModel _viewModel = instance<GetAllIssuesViewModel>();

  @override
  void initState() {
    _viewModel.start() ;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold ,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data
              ?.getScreenWidget(context,_showBody( _viewModel), () {}) ??
              _showBody( _viewModel);
        },
      )
    );
  }
}

Widget _showBody(GetAllIssuesViewModel viewModel){
  return  Padding(
    padding:EdgeInsets.symmetric(horizontal: 20.w),
    child: Column(
      children: [
        SizedBox(height: 25.h),
        const CustomAppBar(title: "All Issues"),
        SizedBox(height: 25.h),
        ListView.builder(
          itemCount: viewModel.issuesList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return IssueCard(
              currentUserId: viewModel.issuesList[index].issueId ,
              title: viewModel.issuesList[index].issueTitle,
              description: viewModel.issuesList[index].issueDescription,
              taskReference: TaskModel.taggedTask(12, "Task1"),
              taggedUser: viewModel.issuesList[index].taggedUser ,
              createdBy:User(1, "Nabil", "nabil@gmail.com",'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
              isResolved: viewModel.issuesList[index].isSolved,
              onMarkResolved: () {},
            );
          },
        ),
      ],
    ),
  );
}

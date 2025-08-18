import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/constants/constants.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/domain/models/Task/task.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../../application/helpers/get_storage.dart';
import '../../../../../domain/models/user.dart';
import '../../../../sharedwidgets/custom_issue_card.dart';
import '../../../../stateRender/state_render_impl.dart';
import '../../../../utils/colors.dart';
import '../../viewmodel/all_issues_view_model.dart';

/// Still need the createdBy in the API response

class IssuesScreen extends StatefulWidget{
  const IssuesScreen(  {super.key});

  @override
  State<IssuesScreen> createState() => _IssuesScreenState();
}

class _IssuesScreenState extends State<IssuesScreen> {

  //final GetAllIssuesViewModel _viewModel = instance<GetAllIssuesViewModel>();
  late final GetAllIssuesViewModel _viewModel;

  @override
  void initState() {
    _viewModel = context.read<GetAllIssuesViewModel>();
    _viewModel.start() ;
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
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

Widget _showBody(GetAllIssuesViewModel viewModel) {
  return Column(
    children: [
      SizedBox(height: 25.h),
      const CustomAppBar(title: "All Issues"),
      SizedBox(height: 25.h),
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: viewModel.issuesList.isEmpty
              ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  "No Issues Found",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          )
              : ListView.builder(
            itemCount: viewModel.issuesList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Selector<GetAllIssuesViewModel, bool>(
                selector: (_, vm) => vm.issuesList[index].isSolved,
                builder: (_, isResolved, __) {
                  return IssueCard(
                    key: ValueKey(viewModel.issuesList[index].issueId),
                    currentUserId: viewModel.issuesList[index].issueId, //FIX
                    title: viewModel.issuesList[index].issueTitle,
                    description: viewModel.issuesList[index].issueDescription,
                    taskReference: TaskModel.taggedTask(12, "Task1"),
                    taggedUser: viewModel.issuesList[index].taggedUser,
                    createdBy: User(
                        1,
                        "Youssef",
                        "Youssef@gmail.com",
                        Constants.userProfileImageUrl
                    ),
                    isResolved: viewModel.issuesList[index].isSolved,
                    onMarkResolved: () {
                      print("----Test");
                      viewModel.updateIssueStatus(viewModel.issuesList[index].issueId);
                    },
                  );
                }
              );
            },
          ),
        ),
      ),
    ],
  );
}


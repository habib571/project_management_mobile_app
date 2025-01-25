import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/navigation/routes_constants.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/report_issue_viewmodel.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:project_management_app/presentation/sharedwidgets/input_text.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../../domain/models/user.dart';
import '../../../../sharedwidgets/custom_add_button.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../../../searchmember/view/custom_search_delegate.dart';
import '../../../../sharedwidgets/image_widget.dart';
import '../../../../utils/styles.dart';
import '../widgets/assigned_memberchip.dart';
import '../widgets/assigned_taskchip.dart';


class ReportIssueScreen extends StatefulWidget{
   ReportIssueScreen({super.key});

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h,),
                const CustomAppBar(title: "Report issue"),
                SizedBox(height: 35.h,),
                _issueInputTextSection(),
                SizedBox(height: 35.h,),
                _issueDescriptionInputTextSection(),
                SizedBox(height: 35.h,),
                _membersChipSection(),
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

  /*Widget _membersChipSection(BuildContext context){
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start ,
      children: [
        Text("Tag a member", style: robotoBold.copyWith(fontSize: 18),),
        SizedBox(height: 10.h,),

        _viewModel.taggedMember != null ?
              AssignedMemberChip(
                  imageUrl: _viewModel.taggedMember!.imageUrl,
                  userName: _viewModel.taggedMember!.fullName,
                  onDeleted: (){}
              ) :
              CustomAddButton(onTap: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    afterSelectingUser: (selectedMember) {
                      Get.toNamed(AppRoutes.reportIssueScreen);
                    },
                  ),
                );
              }),

      ]
    );
  }*/

  Widget _membersChipSection() {
    return Row(children: [
      Image.asset(
        "assets/user_outline.png",
        height: 40,
      ),
      const SizedBox(
        width: 10,
      ),
      /*Selector<ReportIssueViewModel, bool >(
          selector: (_, viewModel) => viewModel.isUserAdded ,
          builder: (context, isUserAdded, _) {
            return isUserAdded && _viewModel.taggedMember != null
                ? AssignedMemberChip(
              imageUrl: context.read<ReportIssueViewModel>().taggedMember!.imageUrl ,
              userName:context.read<ReportIssueViewModel>().taggedMember!.fullName,
              onDeleted: () {
                context.read<ReportIssueViewModel>().toggleIsUserAdded();
              },
            )
              : InkWell(
              onTap: () {
                 context.read<ReportIssueViewModel>().toggleIsUserAdded();
                 showSearch(
                   context: context,
                   delegate: CustomSearchDelegate(
                     afterSelectingUser: (selectedMember) {
                       context.read<ReportIssueViewModel>().updatetaggedMember(selectedMember);
                       Get.toNamed(AppRoutes.reportIssueScreen);
                     },
                   ),
                 );
                //Get.to(() => MembersScreen(),arguments: _viewModel.projectViewModel);
              },
              child: Image.asset("assets/add_filled.png", height: 40),
            );
          })*/

      Selector<ReportIssueViewModel, bool>(
  selector: (_, viewModel) => viewModel.isUserAdded && viewModel.taggedMember != null,
  builder: (context, isUserAdded, _) {
    return isUserAdded
        ? AssignedMemberChip(
            imageUrl: context.read<ReportIssueViewModel>().taggedMember!.imageUrl,
            userName: context.read<ReportIssueViewModel>().taggedMember!.fullName,
            onDeleted: () {
              context.read<ReportIssueViewModel>().toggleIsUserAdded();
            },
          )
        : InkWell(
            onTap: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  afterSelectingUser: (selectedMember) {
                    context.read<ReportIssueViewModel>().updatetaggedMember(selectedMember);
                    Get.toNamed(AppRoutes.reportIssueScreen);
                  },
                ),
              );
            },
            child: Image.asset("assets/add_filled.png", height: 40),
          );
  },
)


    ]);
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




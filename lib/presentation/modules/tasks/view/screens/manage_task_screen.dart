import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/constants/constants.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/screens/members_screen.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/assigned_member_chip.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task%20status/task_status_chip.dart';
import 'package:project_management_app/presentation/modules/tasks/viewmodel/manage_task_view_model.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';
import 'package:provider/provider.dart';
import '../../../../../domain/models/Task/task_chip.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../../../../sharedwidgets/input_text.dart';
import '../../../../stateRender/state_render_impl.dart';
import '../widget/task priority/task_priority_chip.dart';

class ManageTaskScreen extends StatefulWidget {
  const ManageTaskScreen({super.key});

  @override
  State<ManageTaskScreen> createState() => _ManageTaskScreenState();
}

class _ManageTaskScreenState extends State<ManageTaskScreen> {
  //final ManageTaskViewModel _viewModel = instance<ManageTaskViewModel>(param1: Get.arguments?["toEdit"] );
   late ManageTaskViewModel _viewModel ;

  @override
  void initState() {
    _viewModel =  Provider.of<ManageTaskViewModel>(context, listen: false) ;
    _viewModel.start();
    super.initState();
  }

   @override
   void didChangeDependencies() {
     final currentToEdit = Get.arguments?["toEdit"] ?? false;
     if (currentToEdit != _viewModel.toEdit) {
       //_viewModel = Provider.of<ManageTaskViewModel>(context, listen: false);
       _viewModel.toEdit = currentToEdit;
       _viewModel.start();
     }
     super.didChangeDependencies();
   }



   @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: AppColors.scaffold ,
      body: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data
                ?.getScreenWidget(context, _showBody(context), () {}) ??
                _showBody(context);
          },
        ))
      );

  }

  Widget _showBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25.h,
          ),
          CustomAppBar(
            title: _viewModel.toEdit ? 'Update Task' : 'Add Task' ,
            onPressed: (){
              _viewModel.initData() ;
            } , ),
          SizedBox(height: 30.h),
          _taskNameSection(),
          SizedBox(height: 30.h),
          _descriptionSection(),
          SizedBox(height: 30.h),
          _deadlineSection(context),
          SizedBox(height: 30.h),
          Text( _viewModel.toEdit ? 'Update task priority' :'Choose task priority',
              style: robotoBold.copyWith(fontSize: 16)),
          const SizedBox(
            height: 15,
          ),
          _taskPrioritySection(),
          const SizedBox(
            height: 15,
          ),
          _taskStatusSection(),
          SizedBox(height: 30.h),
          Text('Assign user ', style: robotoBold.copyWith(fontSize: 16)),
          const SizedBox(
            height: 15,
          ),
          assignUserSection(),
          SizedBox(
            height: _viewModel.toEdit ? 90.h :120.h,
          ),
          _showButton()
        ],
      ),
    );
  }

  Widget _taskNameSection() {
    return InputText(
      validator: (val) => val.isEmptyInput(),
      controller: _viewModel.taskName,
      hintText: "Enter task name",
      borderSide: const BorderSide(color: Colors.black),
    );
  }

  Widget _descriptionSection() {
    return InputText(
      borderRadius: 15,
      validator: (val) => val.isEmptyInput(),
      controller: _viewModel.taskDescription,
      hintText: "Enter The Task description",
      maxLines: 3,
      borderSide: const BorderSide(color: Colors.black),
    );
  }
  Widget _deadlineSection(BuildContext context) {
    return InputText(
      readOnly: true,
      validator: (val) => val.isEmptyInput(),
      controller: _viewModel.taskDeadline,
      hintText: " Choose Task Deadline",
      suffixIcon: const Icon(Icons.calendar_month_outlined),
      onTap: () async {
         await _viewModel.pickProjectEndDate(context);
      },
      borderSide: const BorderSide(color: Colors.black),
    );
  }

  bool? isSelected = false;
  int itemIndex = -1;

  Widget _taskPrioritySection() {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: List.generate(4, (index) {
        return Selector<ManageTaskViewModel, bool>(
          selector: (_, provider) => provider.selectedPriorityIndex == index,
          builder: (_, isSelected, __) {
            return TaskPriorityChip(
              chipModel: ChipModel(
                priorityChipTexts[index],
                isSelected , // Use the selected state from the provider
                priorityTextColors[index],
                priorityChipColors[index],
              ),
              onSelect: (_) {
                _viewModel.selectPriorityChip = index ;
              },
            );
          },
        );
      }),
    );
  }

   Widget _taskStatusSection() {
     if (!_viewModel.toEdit) return const SizedBox.shrink();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ' Task Status',
            style: robotoBold.copyWith(fontSize: 17),
          ),
          const SizedBox(height: 15,) ,
          Wrap(
              runSpacing: 8,
              spacing: 8,
              children: List.generate(3, (index) {
                return Selector<ManageTaskViewModel, bool>(
                  selector: (_, provider) => provider.selectedStatusIndex == index,
                  builder: (_, isSelected, __) {
                    return TaskStatusChip(
                        chipModel: ChipModel(
                          statusChipTexts[index],
                          isSelected, // Use the selected state from the provider
                          statusTextColors[index],
                          statusBackgroundColor[index],
                        ),
                        onSelect: (_) {
                          _viewModel.selectStatusChip = index ;
                        },
                      );
                  },
                );
              }))
        ],
      ) ;
   }

  Widget assignUserSection() {
    if(!_viewModel.addUserPermission()) return const SizedBox.shrink();
    return Row(children: [
      Image.asset(
        "assets/user_outline.png",
        height: 40,
      ),
      const SizedBox(
        width: 10,
      ),
      Selector<ManageTaskViewModel, bool>(
          selector: (_, viewModel) => viewModel.isUserAdded,
          builder: (context, isUserAdded, _) {
            return isUserAdded
                ? AssignedMemberChip(
                    imageUrl: Constants.userProfileImageUrl,
                    userName: _viewModel.projectMember.user!.fullName,
                    onDeleted: () {
                      context.read<ManageTaskViewModel>().toggleIsUserAdded();
                    },
                  )
                : InkWell(
                    onTap: () {
                      // context.read<AddTaskViewModel>().toggleIsUserAdded();
                      Get.to(() => MembersScreen(),arguments: _viewModel.projectViewModel);
                    },
                    child: Image.asset("assets/add_filled.png", height: 40),
                  );
          })
    ]);
  }
  Widget _showButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: CustomButton(onPressed: () {
        _viewModel.toEdit ? _viewModel.updateTask() :_viewModel.addTask() ;
      }, text: _viewModel.toEdit ? 'Update Task' : 'Add Task'),
    );
  }
}

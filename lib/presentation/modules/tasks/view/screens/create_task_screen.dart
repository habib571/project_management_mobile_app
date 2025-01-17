import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/constants/constants.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/screens/members_screen.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/assigned_member_chip.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task_priority_chip.dart';
import 'package:project_management_app/presentation/modules/tasks/viewmodel/add_task_view_model.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:project_management_app/presentation/utils/styles.dart';
import 'package:provider/provider.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../../../../sharedwidgets/input_text.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final AddTaskViewModel _viewModel = instance.get<AddTaskViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _showBody(context),
      ),
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
          const CustomAppBar(title: 'Add Task'),
          SizedBox(height: 30.h),
          _taskNameSection(),
          SizedBox(height: 30.h),
          _descriptionSection(),
          SizedBox(height: 30.h),
          _deadlineSection(context),
          SizedBox(height: 30.h),
          Text('Choose task priority',
              style: robotoBold.copyWith(fontSize: 16)),
          const SizedBox(
            height: 15,
          ),
          _taskPrioritySection(),
          SizedBox(height: 30.h),
          Text('Assign user ', style: robotoBold.copyWith(fontSize: 16)),
          const SizedBox(
            height: 15,
          ),
          assignUserSection(),
          SizedBox(
            height: 120.h,
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
    );
  }

  Widget _descriptionSection() {
    return InputText(
      borderRadius: 15,
      validator: (val) => val.isEmptyInput(),
      controller: _viewModel.taskDescription,
      hintText: "Enter The Task description",
      maxLines: 3,
    );
  }
  Widget _deadlineSection(BuildContext context) {
    return InputText(
      readOnly: true,
      validator: (val) => val.isEmptyInput(),
      controller: _viewModel.taskDescription ,
      hintText: " Choose Task Deadline",
      suffixIcon: const Icon(Icons.calendar_month_outlined),
      onTap: () async {
         await _viewModel.pickProjectEndDate(context);
      },
    );
  }

  bool? isSelected = false;
  int itemIndex = -1;

  Widget _taskPrioritySection() {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: List.generate(4, (index) {
        return Selector<AddTaskViewModel, bool>(
          selector: (_, provider) => provider.selectedIndex == index,
          builder: (_, isSelected, __) {
            return TaskPriorityChip(
              chipModel: ChipModel(
                chipTexts[index],
                isSelected, // Use the selected state from the provider
                textColors[index],
                chipColors[index],
              ),
              onSelect: (_) {
                Provider.of<AddTaskViewModel>(context, listen: false)
                    .selectChip(index);
              },
            );
          },
        );
      }),
    );
  }

  Widget assignUserSection() {
    return Row(children: [
      Image.asset(
        "assets/user_outline.png",
        height: 40,
      ),
      const SizedBox(
        width: 10,
      ),
      Selector<AddTaskViewModel, bool>(
          selector: (_, viewModel) => viewModel.isUserAdded,
          builder: (context, isUserAdded, _) {
            return isUserAdded
                ? AssignedMemberChip(
                    imageUrl: Constants.userProfileImageUrl,
                    userName: _viewModel.projectMember.user!.fullName,
                    onDeleted: () {
                      context.read<AddTaskViewModel>().toggleIsUserAdded();
                    },
                  )
                : InkWell(
                    onTap: () {
                      // context.read<AddTaskViewModel>().toggleIsUserAdded();
                      Get.to(() => MembersScreen(),
                          arguments: _viewModel.projectViewModel);
                    },
                    child: Image.asset("assets/add_filled.png", height: 40),
                  );
          })
    ]);
  }
  Widget _showButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: CustomButton(onPressed: () {}, text: 'Add Task'),
    );
  }
}

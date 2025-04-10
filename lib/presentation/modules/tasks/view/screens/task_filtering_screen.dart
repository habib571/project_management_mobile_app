import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task%20status/task_status_chip.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task_status_card.dart';
import 'package:project_management_app/presentation/modules/tasks/viewmodel/all_tasks_view_model.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/models/Task/task_chip.dart';
import '../../../../sharedwidgets/input_text.dart';
import '../widget/task priority/task_priority_chip.dart';

class TaskFilteringScreen extends StatefulWidget {
  const TaskFilteringScreen({super.key});

  @override
  State<TaskFilteringScreen> createState() => _TaskFilteringScreenState();
}

class _TaskFilteringScreenState extends State<TaskFilteringScreen> {
  late AllTasksViewModel _viewModel ;
  @override
  void initState() {
    _viewModel = context.read<AllTasksViewModel>() ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: _showBody(context),
    );
  }

  Widget _showBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),
        const CustomAppBar(title: "Advanced Filtering"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              _showOnlyMyTasks() ,
              SizedBox(height: 40.h),
              _statusSection(context),
              SizedBox(height: 40.h),
              _prioritySection(context) ,
              SizedBox(height: 40.h),
              _deadlineSection(context) ,
              SizedBox(height: 150.h),
              _searchButton()


            ],
          ),
        ),
      ],
    );
  }

  Widget _showOnlyMyTasks() {
    return Row(
      children: [
        Text(
          "Only My tasks",
          style: robotoSemiBold.copyWith(fontSize: 14),
        ),
        const SizedBox(
          width: 15,
        ),
        Selector<AllTasksViewModel, bool>(
            selector: (_, provider) => provider.isChecked,
            builder: (_, isChecked, __) {
              return Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    _viewModel.setChecked(value!) ;

              }) ;
            }
    )
        

      ],
    );
  }

  Widget _statusSection(BuildContext context) {
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
              return Selector<AllTasksViewModel, bool>(
                selector: (_, provider) => provider.selectedStatusIndex == index,
                builder: (_, isSelected, __) {
                  return TaskPriorityChip(
                    chipModel: ChipModel(
                      statusChipTexts[index],
                      isSelected, // Use the selected state from the provider
                      statusTextColors[index],
                      statusBackgroundColor[index],
                    ),
                    onSelect: (_) {
                      _viewModel .selectStatus(index);
                    },
                  );
                },
              );
            }))
      ],
    );
  }

  Widget _prioritySection(BuildContext context) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text(
           ' Task Priority',
           style: robotoBold.copyWith(fontSize: 17),
         ),
         const SizedBox(height: 15,) ,
         Wrap(
             runSpacing: 8,
             spacing: 8,
             children: List.generate(4, (index) {
               return Selector<AllTasksViewModel, bool>(
                 selector: (_, provider) => provider.selectedPriorityIndex == index,
                 builder: (_, isSelected, __) {
                   return TaskPriorityChip(
                     chipModel: ChipModel(
                       priorityChipTexts[index],
                       isSelected, // Use the selected state from the provider
                       priorityTextColors[index],
                       priorityChipColors[index],
                     ),
                     onSelect: (_) {
                       _viewModel .selectPriority(index) ;
                     },
                   );
                 },
               );
             }))
       ],
     );
  }

  Widget _deadlineSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ' Task Deadline',
          style: robotoBold.copyWith(fontSize: 17),
        ),
        const SizedBox(height: 15,) ,
        InputText(
          readOnly: true,
          validator: (val) => val.isEmptyInput(),
          controller: _viewModel.taskDeadline ,
          hintText: " Choose Date",
          suffixIcon: const Icon(Icons.calendar_month_outlined),
          onTap: () async {
            await _viewModel.pickProjectEndDate(context);
          },
        ),
      ],
    );
  }
  Widget _searchButton() {
     return Padding(
         padding: EdgeInsets.symmetric(horizontal: 50.w) ,
        child: CustomButton(
             widget: const Icon(Icons.search_rounded ,color: Colors.white,),
            onPressed: () {},
            text: "Search"
        ),
     );
  }
}

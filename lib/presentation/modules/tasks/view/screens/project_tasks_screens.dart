import 'package:flutter/material.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/domain/models/Task/task.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task_widget.dart';
import 'package:project_management_app/presentation/modules/tasks/viewmodel/prject_tasks_view_model.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../../../../stateRender/state_render_impl.dart';
import '../../../../utils/colors.dart';

class ProjectTasksScreens extends StatefulWidget {
  ProjectTasksScreens({super.key});

  @override
  State<ProjectTasksScreens> createState() => _ProjectTasksScreensState();
}

class _ProjectTasksScreensState extends State<ProjectTasksScreens> {
  late final ProjectTasksViewModel _viewModel ;
  @override
  void initState() {
    _viewModel = context.read<ProjectTasksViewModel>() ;
    _viewModel.start() ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
        body: _showBody()
    );
  }

  Widget _showBody() {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          children: [
            const CustomAppBar(title: "All Tasks" , ),
            const SizedBox(height: 10) ,
            _showTaskList()
          ],
        ),

      ),
    );
  }

  Widget _showTaskList() {
    return ValueListenableBuilder<FlowState>(
      valueListenable: _viewModel.stateNotifier,
      builder: (context, state, child) {
        if (state is LoadingState && _viewModel.tasks.isEmpty ) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorState) {
          return Center(child: Text(state.message));
        } else if (state is ContentState) {
          final tasks = _viewModel.tasks;
          if (tasks.isEmpty) {
            return const Center(child: Text("No members found"));
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent && !_viewModel.isLoadingMore) {
                // Fetch next page.
                _viewModel.getProjectTasks();
              }
              return false;
            },

            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length + 1,
              itemBuilder: (context, index) {
                if (index == tasks.length) {
                  return _viewModel.isLoadingMore
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox.shrink();
                }
                final task = tasks[index];
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: TaskWidget(
                    task: task ,
                    viewModel: _viewModel ,
                    isTaskEditable:  _viewModel.isTaskEditable(task),
                  )
                );
              },

            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/modules/tasks/view/screens/task_filtering_screen.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task_widget.dart';
import 'package:project_management_app/presentation/sharedwidgets/input_text.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/all_tasks_view_model.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            _showSearchBar() ,
            SizedBox(height: 35,) ,
            _buildTaskList()
          ],
        ),
      ),
    );
  }

  Widget _showSearchBar() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: InputText(
            onChanged: (val) {
              _viewModel.setSearchQuery(val) ;
              _viewModel.searchTasks() ;
            },
            controller:_viewModel.searchController ,
            prefixIcon: const Icon(Icons.search),
            hintText: "Enter task name",
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              Get.to(() => const TaskFilteringScreen());
            },
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset("assets/filter.png"),
              ),
            ),
          ),
        )
      ],
    );
  }
  Widget _buildTaskList() {
    return ValueListenableBuilder<FlowState>(
      valueListenable: _viewModel.stateNotifier,
      builder: (context, state, child) {
        if (state is LoadingState && _viewModel.tasks.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorState) {
          return Center(child: Text(state.message));
        } else if (state is ContentState) {
          final tasks = _viewModel.tasks;
          if (tasks.isEmpty) {
            return const Center(child: Text("No Tasks found"));
          }
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: tasks.length + (_viewModel.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < tasks.length) {
                    final task = tasks[index];
                    return TaskWidget(task: task);
                  } else {
                    return Center(
                      child: _viewModel.isLoadingMore
                          ? const CircularProgressIndicator()
                          : TextButton(
                        onPressed: () {
                          _viewModel.filterTasks();
                        },
                        child: const Text(
                          "Load More",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

}

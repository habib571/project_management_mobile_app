import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/navigation/routes_constants.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/screens/projet_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../../../stateRender/state_render_impl.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../../viewmodel/dashboard_view_model.dart';
import '../widgets/animated_indicator.dart';
import '../widgets/dashboard_task_card.dart';
import '../widgets/project_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashBoardViewModel _viewModel = instance<DashBoardViewModel>();

  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }

  Future<void> _onRefresh() async {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: snapshot.data?.getScreenWidget(
                  context,
                  _showBody(context),
                  () => _viewModel.start(),
                ) ??
                _showBody(context),
          );
        },
      ),
    );
  }

  Widget _showBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Text('My Workspaces (projects)',
                style: robotoBold.copyWith(fontSize: 18)),
            const SizedBox(height: 25),
            _showProjectsSection(),
            SizedBox(height: 50.h),
            Text('In Progress', style: robotoBold.copyWith(fontSize: 18)),
            const SizedBox(height: 25),
            _showTasksAndIndicators(context),
          ],
        ),
      ),
    );
  }

  Widget _showProjectsSection() {
    return Column(
      children: [
        _showProjects(),
        const SizedBox(height: 30),
        Center(child: _showProjectIndicator()),
      ],
    );
  }

  Widget _showProjects() {
    return CarouselSlider(
      items: List.generate(
        _viewModel.projectList.length,
        (index) {
          return ProjectCard(
            project: _viewModel.projectList[index],
            onTap: ()  {
               Get.to(()=> ProjectDetailScreen()) ;

            },
          );
        },
      ),
      options: CarouselOptions(
        height: 150.h,
        onPageChanged: (index, reason) {
          _viewModel.setProject(_viewModel.projectList[index]);
          context.read<DashBoardViewModel>().setCurrentProject(index);
        },
      ),
    );
  }

  Widget _showProjectIndicator() {
    return Selector<DashBoardViewModel, int>(
      selector: (_, viewModel) => viewModel.currentProject,
      builder: (_, currentProject, __) {
        return AnimatedIndicator(
          activeIndex: currentProject,
          count: _viewModel.projectList.length,
          dotColor: AppColors.primary,
        );
      },
    );
  }

  Widget _showTasksAndIndicators(BuildContext context) {
    return Selector<DashBoardViewModel, int>(
      selector: (_, viewModel) => viewModel.currentTask,
      builder: (_, currentTask, __) {
        return Column(
          children: [
            CarouselSlider(
              items: const [
                DashboardTasCard(),
                DashboardTasCard(),
                DashboardTasCard()
              ],
              options: CarouselOptions(
                height: 150.h,
                padEnds: false,
                initialPage: currentTask,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                onPageChanged: (index, reason) {
                  context.read<DashBoardViewModel>().setCurrentTask(index);
                },
              ),
            ),
            const SizedBox(height: 30),
            AnimatedIndicator(
              activeIndex: currentTask,
              count: 3,
              dotColor: AppColors.primary,
            ),
          ],
        );
      },
    );
  }
}

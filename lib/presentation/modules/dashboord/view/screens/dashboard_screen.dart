import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:provider/provider.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../../viewmodel/dashboard_view_model.dart';
import '../widgets/animated_indicator.dart';
import '../widgets/dashboard_task_card.dart';
import '../widgets/project_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              Text('My Workspaces(projects)',
                  style: robotoBold.copyWith(fontSize: 18)),
              const SizedBox(height: 25),
              _showProjectsAndIndicators(context),
              SizedBox(height: 50.h),
              Text('In Progress', style: robotoBold.copyWith(fontSize: 18)),
              const SizedBox(height: 25),
              _showTasksAndIndicators(context),
            ],
          ),
        ),
      ),
    );
  }


  Widget _showProjectsAndIndicators(BuildContext context) {
    return Selector<DashBoardViewModel, int>(
      selector: (_, viewModel) => viewModel.currentProject,
      builder: (_, currentProject, __) {
        return Column(
          children: [
            CarouselSlider(
              items: const [ProjectCard(), ProjectCard(), ProjectCard()],
              options: CarouselOptions(
                height: 150.h,
                padEnds: false,
                initialPage: currentProject,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 200),
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  context.read<DashBoardViewModel>().currentProject = index;
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 30),
            AnimatedIndicator(
              activeIndex: currentProject,
              count: 3,
              dotColor: AppColors.primary,
            ),
          ],
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
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 200),
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  context.read<DashBoardViewModel>().currentTask = index;
                },
                scrollDirection: Axis.horizontal,
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

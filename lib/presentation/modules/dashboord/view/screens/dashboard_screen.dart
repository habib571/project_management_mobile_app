import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/animated_indicator.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/dashboard_task_card.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/project_card.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentProject = 0;
  int _currentTask = 0;
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
              SizedBox(
                height: 50.h,
              ),
              Text('My Workspaces(projects)',
                  style: robotoBold.copyWith(fontSize: 18)),
              const SizedBox(
                height: 25,
              ),
              _showProjects(),
              const SizedBox(
                height: 30,
              ),
              Center(child:_showProjectIndicators()),
              SizedBox(
                height: 50.h,
              ),
              Text('In Progress', style: robotoBold.copyWith(fontSize: 18)),
              const SizedBox(
                height: 25,
              ),
              _showTasks(),
              const SizedBox(
                height: 30,
              ),
              Center(child:_showTaskIndicators()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showProjects() {
    return CarouselSlider(
        items: const [ProjectCard(), ProjectCard(), ProjectCard()],
        options: CarouselOptions(
          height: 150.h,
          padEnds: false,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 200),
          enlargeCenterPage: false,
          onPageChanged: (index, reason) {
            setState(() {
              _currentProject = index;
            });
          },
          scrollDirection: Axis.horizontal,
        ));
  }

  Widget _showProjectIndicators() {
    return AnimatedIndicator(
        activeIndex: _currentProject, count: 3, dotColor: AppColors.primary);
  }
  Widget _showTaskIndicators() {
    return AnimatedIndicator(
        activeIndex: _currentTask, count: 3, dotColor: AppColors.primary);
  }

  Widget _showTasks() {
    return CarouselSlider(
        items: const [
          DashboardTasCard(),
          DashboardTasCard(),
          DashboardTasCard()
        ],
        options: CarouselOptions(
          height: 150.h,
          padEnds: false,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 200),
          enlargeCenterPage: false,
          onPageChanged: (index, reason) {
            setState(() {
              _currentTask = index;
            });
          },
          scrollDirection: Axis.horizontal,
        ));
  }
}

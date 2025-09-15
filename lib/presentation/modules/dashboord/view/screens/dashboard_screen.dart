import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';

import 'package:project_management_app/application/navigation/routes_constants.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/screens/project_details/projet_detail_screen.dart';
import 'package:project_management_app/presentation/sharedwidgets/input_text.dart';

import 'package:provider/provider.dart';
import '../../../../../domain/models/project.dart';
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
  late final DashBoardViewModel _viewModel  ;

  @override
  void initState() {
    _viewModel = context.read<DashBoardViewModel>() ;
    _viewModel.start();
    super.initState();
  }

  Future<void> _onRefresh() async {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            _showSearchBar(),
            const SizedBox(height: 10),
          _showProjectsSection(),
            SizedBox(height: 100.h),

          ],
        ),
      ),
    );
  }
  Widget _showSearchBar() {
    return Card(
      shadowColor: AppColors.accent.withOpacity(0.5) ,
      elevation: 5,
      child: InputText(
        prefixIcon: const Icon(Icons.search_outlined),
        controller: TextEditingController(),
        hintText: "search...",
      ),
    ) ;
  }

  Widget _showProjectsSection() {
    return Selector<DashBoardViewModel, List<Project>>(
      selector: (_, viewModel) => viewModel.projectList,
      builder: (_, projects, __) {
        if (projects.isEmpty) {
          return const Center(child: Text("No projects available"));
        }

        return ListView.builder(
          shrinkWrap: true, // important to use inside SingleChildScrollView
          physics: const NeverScrollableScrollPhysics(), // avoid nested scrolling
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ProjectCard(
                project: project,
                onTap: () {
                  _viewModel.setProject(project);
                  Get.to(() => const ProjectDetailScreen());
                },
              ),
            );
          },
        );
      },
    );
  }





}

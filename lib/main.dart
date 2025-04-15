import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_it/get_it.dart';
import 'package:project_management_app/application/navigation/routes.dart';
import 'package:project_management_app/presentation/modules/auth/viewmodel/signin-view_model.dart';
import 'package:project_management_app/presentation/modules/auth/viewmodel/signup_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/dashboard_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/project_details_view_models/project_detail_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/report_issue_viewmodel.dart';
import 'package:project_management_app/presentation/modules/manageprojects/viewmodel/manage-project-view-model.dart';
import 'package:project_management_app/presentation/modules/tasks/viewmodel/manage_task_view_model.dart';
import 'package:project_management_app/presentation/modules/tasks/viewmodel/all_tasks_view_model.dart';
import 'package:project_management_app/presentation/modules/tasks/viewmodel/prject_tasks_view_model.dart';
import 'package:project_management_app/presentation/modules/tasks/viewmodel/task_detail_view_model.dart';
import 'package:provider/provider.dart';
import 'application/dependencyInjection/dependency_injection.dart';
import 'application/helpers/screen_configuraton.dart';
import 'application/helpers/token_mamanger.dart';
import 'application/navigation/routes_constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final screenUtility = ScreenConfiguration();
    screenUtility.initialize(context);
    return MultiProvider(
        providers: [

          //Provider( create: (_) => GetIt.instance<ProjectDetailViewModel>()  ), For Test

          ChangeNotifierProvider<SignupViewModel>(
              lazy: true, create: (_) => GetIt.instance<SignupViewModel>()),

          ChangeNotifierProvider<SignInViewModel>(
              lazy: true, create: (_) => GetIt.instance<SignInViewModel>()),
          
          ChangeNotifierProvider<DashBoardViewModel>(
              lazy: true, create: (_) => GetIt.instance<DashBoardViewModel>()),
          
          ChangeNotifierProvider<ManageProjectViewModel>(
            lazy: true,
              create: (_) => GetIt.instance<ManageProjectViewModel>()),
          
          ChangeNotifierProvider<ProjectDetailViewModel>(
              lazy: true,
              create: (_) => GetIt.instance<ProjectDetailViewModel>()),
          
          ChangeNotifierProvider<ReportIssueViewModel>(
              lazy: true,
              create: (_) => GetIt.instance<ReportIssueViewModel>()),

          ChangeNotifierProvider(
              lazy: true, create: (_) => GetIt.instance<ManageTaskViewModel>(/*param1: Get.arguments?["toEdit"]  ?? false ,*/)
          ) ,

          ChangeNotifierProvider<ProjectTasksViewModel>(
              lazy: true,
              create: (_) => GetIt.instance<ProjectTasksViewModel>()),

          ChangeNotifierProvider<TaskDetailsViewModel>(
              lazy: true,
              create: (_) => GetIt.instance<TaskDetailsViewModel>()),

          ChangeNotifierProvider<AllTasksViewModel>(
              lazy: true, create: (_) => GetIt.instance<AllTasksViewModel>()
          ),

        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: AppRoutes.login,
          getPages: routes,
        ));
  }
}




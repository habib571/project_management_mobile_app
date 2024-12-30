import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_it/get_it.dart';
import 'package:project_management_app/application/navigation/routes.dart';
import 'package:project_management_app/presentation/modules/addproject/viewmodel/add-project-view-model.dart';
import 'package:project_management_app/presentation/modules/auth/view/screens/signin_screen.dart';
import 'package:project_management_app/presentation/modules/auth/view/screens/signup_screen.dart';
import 'package:project_management_app/presentation/modules/auth/viewmodel/signin-view_model.dart';
import 'package:project_management_app/presentation/modules/auth/viewmodel/signup_view_model.dart';
import 'package:provider/provider.dart';

import 'application/dependencyInjection/dependency_injection.dart';
import 'application/helpers/screen_configuraton.dart';
import 'application/navigation/routes_constants.dart';

void main()  async{
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
          ChangeNotifierProvider<SignupViewModel>(
              create: (_) => GetIt.instance<SignupViewModel>()),
          ChangeNotifierProvider<SignInViewModel>(
              create: (_) => GetIt.instance<SignInViewModel>()),
          ChangeNotifierProvider<AddProjectViewModel>(
              create: (_) => GetIt.instance<AddProjectViewModel>()),
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

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project_management_app/presentation/modules/auth/view/screens/signin_screen.dart';
import 'package:project_management_app/presentation/modules/auth/view/screens/signup_screen.dart';
import 'package:project_management_app/presentation/modules/auth/viewmodel/signin-view_model.dart';
import 'package:provider/provider.dart';

import 'application/dependencyInjection/dependency_injection.dart';
import 'application/helpers/screen_configuraton.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   initAppModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final screenUtility = ScreenConfiguration();
    screenUtility.initialize(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SignInViewModel>(create: (_) => GetIt.instance<SignInViewModel>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home:  SigninScreen(),
        )
    );
  }
}

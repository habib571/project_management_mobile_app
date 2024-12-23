import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:project_management_app/application/navigation/routes_constants.dart';
import 'package:project_management_app/presentation/modules/auth/view/screens/signin_screen.dart';
import 'package:project_management_app/presentation/modules/auth/view/screens/signup_screen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoutes.login, page:()=> SigninScreen()) ,
  GetPage(name: AppRoutes.signup, page:()=> const SignupScreen()) ,
] ;
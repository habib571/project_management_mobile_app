import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';
import 'package:project_management_app/application/helpers/get_storage.dart';
import 'package:project_management_app/application/navigation/middelware.dart';
import 'package:project_management_app/application/navigation/routes_constants.dart';
import 'package:project_management_app/presentation/modules/auth/view/screens/signin_screen.dart';
import 'package:project_management_app/presentation/modules/auth/view/screens/signup_screen.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/screens/issues_screen.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/screens/members_screen.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/screens/project_details/edit_project_details_screen.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/screens/project_details/projet_detail_screen.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/screens/report_issue_screen.dart';
import 'package:project_management_app/presentation/modules/home/home_screen.dart';
import 'package:project_management_app/presentation/modules/userprofile/View/screens/userprofile_screen.dart';

import '../../presentation/modules/addproject/view/add-project_screen.dart';
import '../../presentation/modules/managemembers/view/screens/manage_members_screen.dart';

List<GetPage<dynamic>>? routes = [  GetPage(name: AppRoutes.login, page:()=> SigninScreen() ,middlewares:  [AuthMiddleware()]) ,
  GetPage(name: AppRoutes.signup, page:()=> const SignupScreen()) ,
  GetPage(name: AppRoutes.home, page:()=>  HomeNavBar()),
  GetPage(name: AppRoutes.addproject, page:()=> ManageProjectScreen()),
  GetPage(name: AppRoutes.userProfile, page:()=>  const UserProfileScreen()),
  //GetPage(name: AppRoutes.projectDetails, page:()=>   const ProjectDetailScreen()),
  GetPage(name: AppRoutes.membersScreen, page: ()=>  MembersScreen()),
  GetPage(name: AppRoutes.addMemberScreen, page: ()=>  const ManageMembersScreen(viewModelType: 'AddMember',)),
  GetPage(name: AppRoutes.updateMemberRoleScreen, page: ()=>  const ManageMembersScreen(viewModelType: 'UpdateMember',)),
  GetPage(name: AppRoutes.reportIssueScreen, page: ()=>   const ReportIssueScreen()),
  GetPage(name: AppRoutes.issuesScreen, page: ()=>  const IssuesScreen()),
  GetPage(name: AppRoutes.editProjectDetailsScreen, page: ()=>  EditProjectDetails())

] ;
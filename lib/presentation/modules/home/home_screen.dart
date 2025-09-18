import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';

import 'package:project_management_app/presentation/modules/dashboord/view/screens/dashboard_screen.dart';
import 'package:project_management_app/presentation/modules/notifications/View/Screens/notfications_historic_screen.dart';
import 'package:project_management_app/presentation/modules/tasks/view/screens/all_task_screen.dart';
import 'package:project_management_app/presentation/modules/userprofile/View/screens/userprofile_screen.dart';

import '../../stateRender/state_render_impl.dart';
import '../../utils/colors.dart';
import '../manageprojects/view/manage-project_screen.dart';
import 'home-viewmodel.dart';

class HomeNavBar extends StatelessWidget {
   HomeNavBar({super.key});

  final HomeViewModel _viewModel = instance<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffold,
        body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data
                ?.getScreenWidget(context, _showBody(context), () {}) ??
                _showBody(context);
          },
        ));
  }


   Widget _showBody(BuildContext context) {
     return PersistentTabView(
       context,
       screens: _buildScreens(),
       items: _navBarsItems(),
       backgroundColor: Colors.white,
       handleAndroidBackButtonPress: true,
       resizeToAvoidBottomInset: true,
       stateManagement: true,
       navBarHeight: 70,
       decoration: NavBarDecoration(
         borderRadius: BorderRadius.circular(30),
         colorBehindNavBar: Colors.transparent,
         boxShadow: [
           BoxShadow(
             color: Colors.black.withOpacity(0.1),
             spreadRadius: 2,
             blurRadius: 10,
             offset: const Offset(0, 3),
           ),
         ],
         border: Border.all(color: Colors.transparent, width: 0),
       ),
       padding: const EdgeInsets.all(0)  ,
       margin: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
       navBarStyle: NavBarStyle.style15,
     );
   }

   List<Widget> _buildScreens() {
     return [
       const DashboardScreen(),
       const AllTasksScreen(),
       ManageProjectScreen(),
       NotificationsHistoric(),
       const UserProfileScreen(),
     ];
   }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
     //   title: ("Home"),
        activeColorPrimary: AppColors.accent,
        inactiveColorPrimary: AppColors.accent,
        activeColorSecondary: AppColors.primary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.task),
       // title: ("Task"),
        activeColorPrimary: AppColors.accent,
        inactiveColorPrimary: AppColors.accent,
        activeColorSecondary: AppColors.primary,
      ),

      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add,),
      //  title: "Add",
        activeColorPrimary: AppColors.accent,
        inactiveColorPrimary: AppColors.accent,
        activeColorSecondary: AppColors.primary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.notifications_active),
    //    title: "Notifications",
        activeColorPrimary: AppColors.accent,
        inactiveColorPrimary: AppColors.accent,
        activeColorSecondary: AppColors.primary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
     //   title: "Profile",
        activeColorPrimary: AppColors.accent,
        inactiveColorPrimary: AppColors.accent,
        activeColorSecondary: AppColors.primary,
      ),
    ];
  }
  }




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';
import 'package:project_management_app/application/navigation/routes_constants.dart';
import 'package:project_management_app/presentation/modules/addproject/view/add-project_screen.dart';

import '../../stateRender/state_render_impl.dart';
import '../../utils/colors.dart';
import '../auth/view/screens/signin_screen.dart';
import '../auth/view/screens/signup_screen.dart';
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
      backgroundColor: AppColors.scaffold,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarHeight: 60,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: AppColors.scaffold,
        border: Border.all(color: AppColors.scaffold, width: 1.0),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }

  List<Widget> _buildScreens() {
    return [
      Test(),
      SignupScreen(),
      SigninScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: AppColors.accent,
        activeColorSecondary: AppColors.primary,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add,),
        title: ("Add"),
        onPressed: (context){
          Get.toNamed(AppRoutes.addproject);
        },
        activeColorPrimary: AppColors.accent,
        inactiveColorPrimary: AppColors.accent,
        activeColorSecondary: AppColors.primary,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: AppColors.accent,
        activeColorSecondary: AppColors.primary,
      ),
    ];
  }
  }


class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
            child:Text("HIIIII")
        )
    ) ;
  }
}


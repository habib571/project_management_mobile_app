import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../utils/colors.dart';
import '../auth/view/screens/signin_screen.dart';
import '../auth/view/screens/signup_screen.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body :_showBody( context)
    );
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


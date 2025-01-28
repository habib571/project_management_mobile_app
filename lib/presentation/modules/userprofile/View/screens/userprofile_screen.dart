import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/modules/userprofile/viewmodel/userprofile_view_model.dart';

import '../../../../../application/constants/constants.dart';
import '../../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../sharedwidgets/image_widget.dart';
import '../../../../stateRender/state_render_impl.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../widgets/custum_list_title.dart';

class UserProfileScreen extends StatefulWidget {
   const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserProfileViewModel _viewModel = instance<UserProfileViewModel>();

  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffold,
        body:  StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data
                ?.getScreenWidget(context, _showBody(), () {}) ??
                _showBody();
          },
        )
    );

  }

  Widget _showBody() {
    return  Center(
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            ImagePlaceHolder(radius: 80.w, imageUrl: Constants.userProfileImageUrl,),
            SizedBox(
              height: 40.h,
            ),
            _userNameSection(_viewModel.user?.fullName?? "Loading..."),
            _userEmailSection(_viewModel.user?.email?? "Loading..."),
            SizedBox(
              height: 25.h,
            ),
            _settingsSection(),
            SizedBox(
              height: 25.h,
            ),
            _changePasswordSection(),
            SizedBox(
              height: 25.h,
            ),
            _logoutSection()
          ],
        ),
      ),
    );
  }


  Widget _userNameSection(String username) {
    return Text(username, style: robotoBold.copyWith(fontSize: 18),);
  }

  Widget _userEmailSection(String username) {
    return Text(username, style: robotoRegular.copyWith(fontSize: 15));
  }

  Widget _settingsSection() {
    return CustomListTitle(icon: Icons.settings_outlined ,title: "Settings",onTap:(){}, );
  }

  Widget _changePasswordSection() {
    return CustomListTitle(icon: Icons.security ,title: "Change password",onTap:(){} );
  }

  Widget _logoutSection() {
    return CustomListTitle(icon: Icons.logout_outlined ,title: "Logout",onTap:(){
      _viewModel.logOut();
    } );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/modules/userprofile/viewmodel/userprofile_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../application/constants/constants.dart';
import '../../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../sharedwidgets/custom_listtile.dart';
import '../../../../sharedwidgets/image_widget.dart';
import '../../../../stateRender/state_render_impl.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';

class UserProfileScreen extends StatefulWidget {
   const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserProfileViewModel _viewModel;
  //final UserProfileViewModel _viewModel = instance<UserProfileViewModel>();

  @override
  void initState() {
    _viewModel = context.read<UserProfileViewModel>() ;
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
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Selector<UserProfileViewModel, XFile?>(
                  selector: (_, viewModel) => viewModel.pickedImage,
                  builder: (BuildContext context, value, Widget? child) {
                    return ImagePlaceHolder(radius: 80.w,
                      imageUrl: _viewModel.pickedImage?.path ?? "" ,
                    //Constants.userProfileImageUrl,
                      fullName: _viewModel.user?.fullName?? "Loading...",
                    );
                  },
                ),
                IconButton(
                  onPressed: () {_viewModel.pickImage(context);},
                  icon: const Icon(Icons.edit_outlined, size: 30,),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.scaffold,
                    padding: const EdgeInsets.all(8),
                    shape: const CircleBorder(),
                  ),
                ),

              ],
            ),

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
    return CustomListTile(leading: const Icon(Icons.settings_outlined,color: AppColors.primary), trailing: const Icon(Icons.arrow_forward_ios ,color: AppColors.accent,size: 13, ) ,title: const Text("Settings"),onTap:(){}, );
  }

  Widget _changePasswordSection() {
    return CustomListTile(leading: const Icon(Icons.security ,color: AppColors.primary), trailing: const Icon(Icons.arrow_forward_ios ,color: AppColors.accent,size: 13, ), title: const Text("Change password"),onTap:(){} );
  }

  Widget _logoutSection() {
    return CustomListTile( leading: const Icon(Icons.logout_outlined ,color: AppColors.primary) , title: const Text("Logout"),onTap:(){
      _viewModel.logOut();
    } );
  }
}
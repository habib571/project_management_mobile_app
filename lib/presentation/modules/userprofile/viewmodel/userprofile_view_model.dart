import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';

import '../../../../application/helpers/token_mamanger.dart';
import '../../../../application/navigation/routes_constants.dart';
import '../../../../domain/models/user.dart';
import '../../../../domain/usecases/auth/userprofile_usecase.dart';
import '../../../stateRender/state_render.dart';
import '../../../utils/colors.dart';

class UserProfileViewModel extends BaseViewModel {

  final UserProfileUseCase _userprofileUseCase ;
  final TokenManager _tokenManager;
  final ImagePicker _picker;
  UserProfileViewModel(super.tokenManager, this._userprofileUseCase, this._tokenManager, this._picker,);

  @override
  void start(){
    getCurrentUserInfo();
    super.start();
  }

  User? _user ;
  User? get user => _user;

  XFile? _pickedImage;
  XFile? get pickedImage => _pickedImage;

  void getCurrentUserInfo()async{
    updateState(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _userprofileUseCase.getCurrentUserInfo()).fold((failure){
      updateState(ErrorState(StateRendererType.snackbarState, failure.message));
    }, (data){
      _user = data ;
      updateState(ContentState());
    }
    );
  }


  Future<void> pickImage(BuildContext context) async {
    final XFile? image = await showDialog<XFile?>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Choose Source",
                style: TextStyle(
                  color: AppColors.primaryTxt,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () async {
                        final picked = await _picker.pickImage(source: ImageSource.camera);
                        Navigator.pop(context, picked);
                      },
                      icon: const Icon(Icons.camera_alt,size: 50,color: AppColors.accent,)
                  ),
                  const SizedBox(width: 30),
                  IconButton(
                      onPressed: () async {
                        final picked = await _picker.pickImage(source: ImageSource.gallery);
                        Navigator.pop(context, picked);
                      },
                      icon: const Icon(Icons.photo_library,size: 50,color: AppColors.accent,)
                  ),
                ],
              ),
              const SizedBox(height: 12),

              TextButton(
                child: const Text("Cancel",style: TextStyle(color:AppColors.secondaryTxt),),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );

    if (image != null) {
      _pickedImage = image;
      updateState(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
      (await _userprofileUseCase.updateProfileImage(image)).fold((failure){
        updateState(ErrorState(StateRendererType.snackbarState, failure.message));
      }, (date) {
        updateState(ContentState());
        notifyListeners();
      });
    }
  }

  void logOut()async{
    updateState(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _userprofileUseCase.logOut()).fold((failure){
      updateState(ErrorState(StateRendererType.snackbarState, failure.message));
    }, (date){
      _tokenManager.clearUserDetails();
      Get.offAllNamed(AppRoutes.login) ;
      updateState(ContentState());
    });
  }

}

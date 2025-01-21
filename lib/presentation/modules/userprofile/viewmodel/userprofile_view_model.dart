import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';

import '../../../../application/helpers/token_mamanger.dart';
import '../../../../application/navigation/routes_constants.dart';
import '../../../../domain/models/user.dart';
import '../../../../domain/usecases/auth/userprofile_usecase.dart';
import '../../../stateRender/state_render.dart';

class UserProfileViewModel extends BaseViewModel {

  final UserProfileUseCase _userprofileUseCase ;
  final TokenManager _tokenManager;
  UserProfileViewModel(super.tokenManager, this._userprofileUseCase, this._tokenManager,);

  @override
  void start(){
    getCurrentUserInfo();
    super.start();
  }

  User? _user ;
  User? get user => _user;

  void getCurrentUserInfo()async{
    updateState(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _userprofileUseCase.getCurrentUserInfo()).fold((failure){
      updateState(ErrorState(StateRendererType.snackbarState, failure.message));
    }, (data){
     // _user=User(data.id,data.fullName, data.email);
      _user = data ;
      updateState(ContentState());
    }
    );
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

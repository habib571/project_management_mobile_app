import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';

import '../../../../application/helpers/get_storage.dart';
import '../../../../application/navigation/routes_constants.dart';
import '../../../../domain/models/user.dart';
import '../../../../domain/usecases/auth/userprofile_usecase.dart';
import '../../../stateRender/state_render.dart';

class UserProfileViewModel extends BaseViewModel {

  final UserProfileUseCase _userprofileUseCase ;
  final LocalStorage _localStorage;
  UserProfileViewModel(super.tokenManager, this._userprofileUseCase, this._localStorage,);

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
      _user=User(data.id,data.fullName, data.email);
      updateState(ContentState());
    }
    );
  }

  void logOut()async{
    updateState(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _userprofileUseCase.logOut()).fold((failure){
      updateState(ErrorState(StateRendererType.snackbarState, failure.message));
    }, (date){
      _localStorage.clearAuthToken();
      Get.offAllNamed(AppRoutes.login) ;
      updateState(ContentState());
    });
  }

}

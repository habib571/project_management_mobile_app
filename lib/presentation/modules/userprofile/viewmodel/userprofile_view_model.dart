import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';

import '../../../../domain/models/user.dart';
import '../../../../domain/usecases/auth/userprofile_usecase.dart';
import '../../../stateRender/state_render.dart';

class UserProfileViewModel extends BaseViewModel {

  @override
  void start(){
    getCurrentUserInfo();
    super.start();
  }

  final UserProfileUseCase _profileUseCase ;
  UserProfileViewModel(super.tokenManager, this._profileUseCase,);

  String  _fullName = "Unknown" ;
  String get fullName => _fullName;

  String _email = "Unknown" ;
  String get email => _email;

  setFullName(User user){
    _fullName = user.fullName;
  }

  setEmail(User user){
    _email = user.email;
  }

  getCurrentUserInfo()async{
    updateState(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _profileUseCase.getCurrentUserInfo()).fold((failure){
      updateState(ErrorState(StateRendererType.snackbarState, failure.message));
    }, (data){
      _fullName = data.fullName;
      _email = data.email;
      updateState(ContentState());
    }
    );
  }

}

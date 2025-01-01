import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project_management_app/application/helpers/get_storage.dart';
import 'package:project_management_app/data/repositoryImp/auth_repo_impl.dart';
import 'package:project_management_app/data/repositoryImp/project_repo_impl.dart';
import 'package:project_management_app/domain/repository/auth_repo.dart';
import 'package:project_management_app/domain/repository/project_repo.dart';
import 'package:project_management_app/domain/usecases/project/myprojects_usecase.dart';
import 'package:project_management_app/presentation/modules/addproject/viewmodel/add-project-view-model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/dashboard_view_model.dart';

import '../../data/dataSource/remoteDataSource/auth_remote_data_source.dart';
import '../../data/dataSource/remoteDataSource/project_data_source.dart';
import '../../data/network/internet_checker.dart';
import '../../domain/usecases/auth/signup_usecase.dart';
import '../../domain/usecases/project/addproject-use-case.dart';
import '../../presentation/modules/addproject/view/add-project_screen.dart';
import '../helpers/token_mamanger.dart';
import '../../domain/usecases/auth/signin_usecase.dart';
import '../../presentation/modules/auth/viewmodel/signin-view_model.dart';
import '../../presentation/modules/auth/viewmodel/signup_view_model.dart';
import '../../presentation/modules/home/home-viewmodel.dart';

GetIt instance = GetIt.instance;
initAppModule() async {
 await initGetStorageModule() ;
 instance.registerLazySingleton<TokenManager>(() =>TokenManager(instance()));
 instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  instance.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp());
  instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(instance(), instance()));
 instance.registerLazySingleton<ProjectDataSource>(
         () => ProjectRemoteDataSource(instance()));
 instance.registerLazySingleton<ProjectRepository>(
         () => ProjectRepositoryImpl(instance(), instance()));


  initSignInModule();
  initSignupModule();
  initHomeModule();
  initDashboard() ;
  intAddProject();

  
}



initHomeModule() {
    instance.registerLazySingleton<HomeViewModel>(() => HomeViewModel(instance()));
}

intAddProject(){
    instance.registerFactory<AddProjectViewModel>(() => AddProjectViewModel(instance(),instance()));
    instance.registerFactory<AddProjectUseCase>(() => AddProjectUseCase(instance()));
}
initDashboard() {
  if (!GetIt.I.isRegistered<GetMyProjectsUseCase>()) {
    instance.registerFactory<GetMyProjectsUseCase>(() => GetMyProjectsUseCase(instance()));
    instance.registerFactory<DashBoardViewModel>(() => DashBoardViewModel(instance() ,instance()) );
  }
}

initSignupModule() {
  if (!GetIt.I.isRegistered<SignupUseCase>()) {
    instance.registerFactory<SignupUseCase>(() => SignupUseCase(instance()));
    instance.registerFactory<SignupViewModel>(() => SignupViewModel(instance() ,instance(),instance()));
  }
}

initSignInModule() {
  if (!GetIt.I.isRegistered<SignInViewModel>()) {
    instance.registerFactory<SignInUseCase>(() => SignInUseCase(instance()));
    instance.registerFactory<SignInViewModel>(
        () => SignInViewModel(instance() ,instance(),instance()));
  }
}

initGetStorageModule() async {
    await GetStorage.init();
    instance.registerLazySingleton<GetStorage>(() => GetStorage());
    instance.registerLazySingleton<LocalStorage>(() =>LocalStorageImp(instance(), instance()));

}
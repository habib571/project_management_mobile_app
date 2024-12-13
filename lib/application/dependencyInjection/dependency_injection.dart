import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project_management_app/data/repositoryImp/auth_repo_impl.dart';
import 'package:project_management_app/domain/repository/auth_repo.dart';
import 'package:project_management_app/domain/usecases/signin_usecase.dart';
import 'package:project_management_app/domain/usecases/signup_usecase.dart';
import 'package:project_management_app/presentation/modules/auth/viewmodel/signin-view_model.dart';
import 'package:provider/provider.dart';

import '../../data/dataSource/localDataSource/auth_local_data_source.dart';
import '../../data/dataSource/remoteDataSource/auth_remote_data_source.dart';
import '../../data/network/internet_checker.dart';
import '../../data/services/token_mamanger.dart';
import '../../presentation/modules/auth/viewmodel/signup_view_model.dart';

GetIt instance = GetIt.instance;
initAppModule()   {
   initGetStorageModule();
   instance.registerLazySingleton<TokenManager>(() => TokenManager());
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  instance.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp());
  instance.registerLazySingleton<AuthLocalDataSource>(
          () => AuthLocalDataSourceImp());
  instance.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(instance(),instance(),instance()));


  initSignupModule();
  initSigninModule();
}

initSignupModule() {
  if (!GetIt.I.isRegistered<SignupUseCase>()) {
    instance.registerFactory<SignupUseCase>(() => SignupUseCase(instance()));
    instance.registerFactory<SignupViewModel>(() => SignupViewModel(instance()));
  }
}

initSigninModule() {
  if (!GetIt.I.isRegistered<SignInViewModel>()) {
    instance.registerFactory<SignInUseCase>(()=>SignInUseCase(instance()));
    instance.registerFactory<SignInViewModel>(() => SignInViewModel(instance()));
  }
}

initGetStorageModule()  {
  // (!GetIt.I.isRegistered<SignInViewModel>()) {
     GetStorage.init();
    instance.registerLazySingleton<GetStorage>(()=>GetStorage());
 // }
}



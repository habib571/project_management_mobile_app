import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project_management_app/data/repositoryImp/auth_repo_impl.dart';
import 'package:project_management_app/domain/repository/auth_repo.dart';
import 'package:project_management_app/domain/usecases/signup_usecase.dart';

import '../../data/dataSource/remoteDataSource/auth_remote_data_source.dart';
import '../../data/network/internet_checker.dart';
import '../../presentation/modules/auth/viewmodel/signup_view_model.dart';

GetIt instance = GetIt.instance;
initAppModule() {
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  instance.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp());
  instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(instance(), instance()));
  initSignupModule();
}

initSignupModule() {
  if (!GetIt.I.isRegistered<SignupUseCase>()) {
    instance.registerFactory<SignupUseCase>(() => SignupUseCase(instance()));
    instance
        .registerFactory<SignupViewModel>(() => SignupViewModel(instance()));
  }
}

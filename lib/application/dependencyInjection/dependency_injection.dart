import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project_management_app/application/helpers/get_storage.dart';
import 'package:project_management_app/data/dataSource/remoteDataSource/task_remote_data_source.dart';
import 'package:project_management_app/data/repositoryImp/auth_repo_impl.dart';
import 'package:project_management_app/data/repositoryImp/project_repo_impl.dart';
import 'package:project_management_app/domain/repository/auth_repo.dart';
import 'package:project_management_app/domain/repository/project_repo.dart';
import 'package:project_management_app/domain/usecases/project/add_member_use_case.dart';
import 'package:project_management_app/domain/usecases/project/get_members.dart';
import 'package:project_management_app/domain/usecases/project/issue/get_allissues_use_case.dart';
import 'package:project_management_app/domain/usecases/project/issue/report_issue_use_case.dart';
import 'package:project_management_app/domain/usecases/project/myprojects_usecase.dart';

import 'package:project_management_app/presentation/modules/addmember/viewmodel/add_member_viewmodel.dart';
import 'package:project_management_app/presentation/modules/addproject/viewmodel/add-project-view-model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/dashboard_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/report_issue_viewmodel.dart';
import 'package:project_management_app/presentation/modules/addmember/viewmodel/search_member_view_model.dart';


import 'package:project_management_app/presentation/modules/userprofile/viewmodel/userprofile_view_model.dart';

import 'package:project_management_app/presentation/modules/dashboord/viewmodel/project_detail_view_model.dart';


import '../../data/dataSource/remoteDataSource/auth_remote_data_source.dart';
import '../../data/dataSource/remoteDataSource/project_data_source.dart';
import '../../data/network/internet_checker.dart';
import '../../data/repositoryImp/task_repo_impl.dart';
import '../../domain/repository/task_repo.dart';
import '../../domain/usecases/auth/signup_usecase.dart';
import '../../domain/usecases/auth/userprofile_usecase.dart';
import '../../domain/usecases/project/addproject-use-case.dart';
import '../../domain/usecases/task/add_task_user_case.dart';
import '../../presentation/modules/addproject/view/add-project_screen.dart';
import '../../presentation/modules/dashboord/viewmodel/all_issues_view_model.dart';
import '../../presentation/modules/tasks/viewmodel/add_task_view_model.dart';
import '../../presentation/modules/tasks/viewmodel/task_detail_view_model.dart';
import '../helpers/token_mamanger.dart';
import '../../domain/usecases/auth/signin_usecase.dart';
import '../../presentation/modules/auth/viewmodel/signin-view_model.dart';
import '../../presentation/modules/auth/viewmodel/signup_view_model.dart';
import '../../presentation/modules/home/home-viewmodel.dart';

GetIt instance = GetIt.instance;
initAppModule() async {

  await initGetStorageModule();
  instance.registerLazySingleton<TokenManager>(() => TokenManager(instance()));
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  instance.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(instance()));
  instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(instance(), instance()));


  instance.registerLazySingleton<ProjectDataSource>(
      () => ProjectRemoteDataSource(instance()));
  instance.registerLazySingleton<ProjectRepository>(
      () => ProjectRepositoryImpl(instance(), instance()));
  instance.registerLazySingleton<TaskRemoteDataSource>(
      () => TaskRemoteDataSourceImpl(instance()));
  instance.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(instance(), instance()));

  initSignInModule();
  initSignupModule();
  initHomeModule();
  initDashboard();
  intAddProject();
  initTask() ;
  initUserProfileModule();
  initProject() ;
  initSearchModule();
  initReportIssueModule();
 initGetAllIssuesModule();

}

initReportIssueModule() {
  if (!GetIt.I.isRegistered<ReportIssueViewModel>()) {
    instance.registerFactory<ReportIssueUseCase>(() => ReportIssueUseCase(instance()));
    instance.registerFactory<ReportIssueViewModel>(() => ReportIssueViewModel(instance(),instance()));

  }
}


initGetAllIssuesModule() {
  if (!GetIt.I.isRegistered<GetAllIssuesViewModel>()) {
    instance.registerFactory<GetAllIssuesUseCase>(() => GetAllIssuesUseCase(instance()));
    instance.registerFactory<GetAllIssuesViewModel>(() => GetAllIssuesViewModel(instance(),instance()));

  }
}

initSearchModule() {
  if (!GetIt.I.isRegistered<SearchViewModel>()) {
    instance.registerLazySingleton<SearchViewModel>(() => SearchViewModel(instance(),instance()));
  }
}



initHomeModule() {
  instance
      .registerLazySingleton<HomeViewModel>(() => HomeViewModel(instance()));
}

intAddProject() {
  instance.registerFactory<AddProjectViewModel>(
      () => AddProjectViewModel(instance(), instance()));
  instance
      .registerFactory<AddProjectUseCase>(() => AddProjectUseCase(instance()));
}

initDashboard() {
  if (!GetIt.I.isRegistered<GetMyProjectsUseCase>()) {
    instance.registerFactory<GetMyProjectsUseCase>(
        () => GetMyProjectsUseCase(instance()));
    instance.registerLazySingleton<DashBoardViewModel>(
        () => DashBoardViewModel(instance(), instance()));
  }

}



initTask() {
  instance.registerLazySingleton<TaskDetailsViewModel>(
      () => TaskDetailsViewModel(instance(), instance()));
    instance.registerFactory<AddTaskUseCase>(() => AddTaskUseCase(instance()));
    instance.registerLazySingleton<AddTaskViewModel>(
        () => AddTaskViewModel(instance(), instance(), instance()));

}



initProject() {
  if (!GetIt.I.isRegistered<GetMembersUseCase>()) {
    instance.registerFactory<GetMembersUseCase>(() => GetMembersUseCase(instance()));
    instance.registerFactory<AddMemberUseCase>(() => AddMemberUseCase(instance()));
    instance.registerFactory<AddMemberViewModel>(() => AddMemberViewModel(instance() ,instance() ,instance()) );
    instance.registerLazySingleton<ProjectDetailViewModel>(() => ProjectDetailViewModel(instance() ,instance() ,instance() ,instance()) );
  }
}


initSignupModule() {
  if (!GetIt.I.isRegistered<SignupUseCase>()) {
    instance.registerFactory<SignupUseCase>(() => SignupUseCase(instance()));
    instance.registerFactory<SignupViewModel>(
        () => SignupViewModel(instance(), instance(), instance()));
  }
}

initSignInModule() {
  if (!GetIt.I.isRegistered<SignInViewModel>()) {
    instance.registerFactory<SignInUseCase>(() => SignInUseCase(instance()));
    instance.registerFactory<SignInViewModel>(
        () => SignInViewModel(instance(), instance(), instance()));
  }
}

initUserProfileModule() {
  if (!GetIt.I.isRegistered<UserProfileViewModel>()) {

    instance.registerLazySingleton<UserProfileUseCase>(
        () => UserProfileUseCase(instance()));
    instance.registerLazySingleton<UserProfileViewModel>(
        () => UserProfileViewModel(instance(), instance(), instance()));
  }
}


initGetStorageModule() async {
  await GetStorage.init();
  instance.registerLazySingleton<GetStorage>(() => GetStorage());
  instance.registerLazySingleton<LocalStorage>(
      () => LocalStorageImp(instance(), instance()));
}

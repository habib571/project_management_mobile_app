

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';
import 'package:project_management_app/application/helpers/get_storage.dart';
import 'package:project_management_app/application/navigation/routes_constants.dart';

import '../helpers/token_mamanger.dart';

class AuthMiddleware extends GetMiddleware {

  final LocalStorage _localStorageImp = instance<LocalStorage>() ;

  @override
  RouteSettings? redirect(String? route) {
    if (_localStorageImp.isUserLoggedIn) {
      _localStorageImp.clearAuthToken();
      return  const RouteSettings(name: AppRoutes.home);
    }
    return null;
  }
}
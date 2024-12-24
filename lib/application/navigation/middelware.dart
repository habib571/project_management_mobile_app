

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';
import 'package:project_management_app/application/helpers/get_storage.dart';
import 'package:project_management_app/application/navigation/routes_constants.dart';

class AuthMiddleware extends GetMiddleware {
  final LocalStorage localStorageImp = instance<LocalStorage>() ;


  @override
  RouteSettings? redirect(String? route) {
    if (localStorageImp.isUserLoggedIn) {
      return  const RouteSettings(name: AppRoutes.home);
    }
    return null;
  }
}
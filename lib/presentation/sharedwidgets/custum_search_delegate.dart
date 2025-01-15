import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/modules/addmember/view/screens/add_member_screen.dart';
import 'package:project_management_app/presentation/sharedwidgets/custum_listtile.dart';

import '../../application/constants/constants.dart';
import '../../domain/models/user.dart';
import 'image_widget.dart';



class CustomSearchDelegate extends SearchDelegate<User?> {

  final List<User> names=[
    User(1, "ahmed", "ahmed",Constants.userProfileImageUrl) , User(2, "rami", "rami",Constants.userProfileImageUrl) , User(3, "mohsssen", "mohsssen",Constants.userProfileImageUrl)
  ] ;

  final String searchLabel;

  CustomSearchDelegate(this.searchLabel);

  @override
  String? get searchFieldLabel => searchLabel;


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<User> results = names.asMap()
        .entries
        .where((entry) => entry.value.fullName.toLowerCase().contains(query.toLowerCase()))
        .map((entry) => User(entry.key ,entry.value.fullName ,entry.value.email,entry.value.imageUrl))
        .toList();
    return AddMemberScreen(user: results[0]);
      /*Padding(
      padding:  EdgeInsets.symmetric(horizontal: 25.w),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return CustumListTitle(
              leading:  ImagePlaceHolder(radius: 25.w,imageUrl: results[index].imageUrl) ,
              subtitle: Text(results[index].email),
              title: results[index].fullName,
              onTap: () {
                Get.to(AddMemberScreen(user: results[0]));
                //close(context, results[index]);
              });
        },
      ),
    );*/
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<User> suggestions = names
        .where((name) => name.fullName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 25.w),
      child: ListView.builder(
        itemCount: suggestions.length,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemBuilder: (context, index) {
          return Padding(
            padding:  EdgeInsets.symmetric(vertical: 8.h),
            child: CustumListTitle(
              leading: ImagePlaceHolder(radius: 25.w, imageUrl: suggestions[index].imageUrl),
              subtitle: Text(suggestions[index].email),
              title: suggestions[index].fullName,
              onTap: () {
                query = suggestions[index].fullName;
                showResults(context);
              },
            ),
          );
        },
      ),
    );

  }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/sharedwidgets/custum_listtile.dart';

import '../../../../../domain/models/user.dart';
import '../../../../sharedwidgets/image_widget.dart';
import '../../../../sharedwidgets/input_text.dart';
import '../../../../utils/colors.dart';

class AddMemberScreen extends StatelessWidget{
  final User user;
  const AddMemberScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: Column(children:[
        Text(user.fullName),
        CustumListTitle(
            leading: ImagePlaceHolder(radius: 25.w,imageUrl: user.imageUrl),
            subtitle: Text(user.email),
            title: user.fullName, 
            onTap: (){}
        ),
        InputText(hintText: "Add Role",)
      ] ),
    );
  }
}
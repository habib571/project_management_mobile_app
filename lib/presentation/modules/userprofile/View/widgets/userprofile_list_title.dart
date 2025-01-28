import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/utils/colors.dart';

class UserProfileListTitle extends StatelessWidget {
  final Widget? leading;
  final String title;
  final void Function()? onTap;

  const UserProfileListTitle({super.key,  required this.leading,required this. title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      data:const ListTileThemeData(
        tileColor:  Colors.white ,
      ),
      child: ListTile(
        leading: leading,
        //CircleAvatar(backgroundColor: AppColors.scaffold,child: Icon(icon,color: AppColors.primary ),) ,
        trailing: const Icon(Icons.arrow_forward_ios ,color: AppColors.accent,size: 13, ),
        title: Text(title),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      )
    );

  }

}
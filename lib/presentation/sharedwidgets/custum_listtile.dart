import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustumListTitle extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget? subtitle;
  final void Function()? onTap;

  const CustumListTitle({super.key,  required this.leading,required this. title,required this.onTap,this.subtitle});

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
          subtitle: subtitle,
          title: Text(title),
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        )
    );

  }

}
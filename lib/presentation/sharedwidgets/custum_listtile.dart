import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustumListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final void Function()? onTap;

  const CustumListTile({super.key,  required this.leading,required this. title,required this.onTap,this.subtitle,this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
        data:const ListTileThemeData(
          tileColor:  Colors.white ,
        ),
        child: ListTile(
          leading: leading,
          trailing: trailing,
          subtitle: Text(subtitle??""),
          title: Text(title),
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        )
    );

  }

}
import 'package:flutter/material.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

class MemberLisTile extends StatelessWidget {

  const MemberLisTile({super.key, required this.projectMember, required this.onTap});

  final ProjectMember projectMember;
  final Function onTap ;


  @override
  Widget build(BuildContext context) {
    return ListTile(

       onTap: () {
         onTap() ;
       },

      contentPadding: const EdgeInsets.all(15),
      title: Text(
            projectMember.user!.fullName ,
          style: robotoBold.copyWith(fontSize: 14)
      ),
      subtitle: Text(
           projectMember.role! , style: robotoRegular.copyWith(fontSize: 12),),
      leading: const ImagePlaceHolder(radius: 30,
          imageUrl: 'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
    );
  }

}
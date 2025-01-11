import 'package:flutter/material.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

class MemberLisTile extends StatelessWidget {
  const MemberLisTile({super.key});

 // final ProjectMember projectMember;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(15),
      title: Text(
           "habib rouatbi",
          style: robotoBold.copyWith(fontSize: 14)
      ),
      subtitle: Text(
          "Manger", style: robotoRegular.copyWith(fontSize: 12),),
      leading: const ImagePlaceHolder(radius: 30,
          imageUrl: 'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
    );
  }

}
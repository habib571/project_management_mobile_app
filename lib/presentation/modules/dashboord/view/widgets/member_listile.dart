import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:project_management_app/application/navigation/routes_constants.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';
import '../../../../../application/constants/constants.dart';
import '../../viewmodel/project_details_view_models/project_detail_view_model.dart';

class MemberLisTile extends StatelessWidget {

  const MemberLisTile({super.key, required this.projectMember, required this.onTap, required this.viewModel});

  final ProjectDetailViewModel viewModel ;
  final ProjectMember projectMember;
  final Function onTap ;

  @override
  Widget build(BuildContext context) {

    return ListTile(
      contentPadding: const EdgeInsets.all(15),
      title: Text(projectMember.user!.fullName ,style: robotoBold.copyWith(fontSize: 14)),
      subtitle: Text(projectMember.role! , style: robotoRegular.copyWith(fontSize: 12),),
      trailing: IconButton(
          onPressed: ()=>_showMemberOptions(context, projectMember),
          icon: const Icon(Icons.menu_outlined)) ,
      leading: ImagePlaceHolder(radius: 30,
          imageUrl: projectMember.user!.imageUrl,
          fullName: projectMember.user!.fullName,
      ),
      onTap: () {
        onTap() ;
      },
    );
  }

  void _showMemberOptions(BuildContext context, ProjectMember member) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: AppColors.primary),
              title: const Text("Edit role"),
              onTap: () {
                Navigator.pop(context);
                ProjectMember newMember = ProjectMember.selectedMemberToBeUpdated(member.id,member.user, member.project!.id, member.role);
                Get.toNamed(AppRoutes.manageMemberScreen,arguments: {"member": newMember,"toEdit": true,});
                //Get.toNamed(AppRoutes.updateMemberRoleScreen ,arguments: newMember, );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: AppColors.primary),
              title: const Text("Delete"),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmationDialog(context, member);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, ProjectMember member) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:  Text("Delete ${member.user!.fullName} ?"),
          content: const Text("This action is irreversible."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                print(projectMember.id!);
                viewModel.deleteMember(projectMember.id!);
                Navigator.pop(context);
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

}

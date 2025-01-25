import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/custom_chips/assigned_memberchip.dart';
import 'package:project_management_app/presentation/utils/colors.dart';

import '../../domain/models/user.dart';
import '../modules/dashboord/view/widgets/custom_chips/assigned_taskchip.dart';
import '../utils/styles.dart';
import 'image_widget.dart';

class IssueCard extends StatelessWidget {
  final String title;
  final String description;
  final String taskReference; //task object
  final User? taggedUser;
  final User createdBy;
  final bool isResolved;
  final VoidCallback onMarkResolved;
  final int currentUserId ;


  const IssueCard({
    Key? key,
    required this.title,
    required this.description,
    required this.taskReference,
    required this.taggedUser,
    required this.createdBy,
    required this.currentUserId,
    this.isResolved = false,
    required this.onMarkResolved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation:0,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                //overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              isResolved ? Icons.check_circle : Icons.error,
              color: isResolved ? Colors.green : Colors.red,
            ),
          ],
        ),
        subtitle: RichText(
          text: TextSpan(
            children: [
               TextSpan(
                text: 'Reported by: ',
                style:robotoSemiBold.copyWith(fontSize: 13)
              ),
              TextSpan(
                text: createdBy.fullName,
                style:robotoRegular.copyWith(fontSize: 14)

              ),
            ],
          ),
        ),
        leading: ImagePlaceHolder(radius: 20, imageUrl: createdBy.imageUrl),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reported Task :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Wrap(
                        runSpacing: 8,
                        spacing: 8,
                        children: [
                          AssignedTaskChip(taskName: "Task 1", onDeleted: () {}),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 11.h),
                _taggedMembersSection(taggedUser),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: _issueCardButton(createdBy, currentUserId)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


Widget _issueCardButton(User createdBy,int currentUserId ){
  return ElevatedButton(
    onPressed: (){},
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
    ),
    child:Text(
      createdBy.id == currentUserId ?  "Delete Issue" : "Mark as Resolved" ,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

Widget _taggedMembersSection(User? taggedUser){
  return taggedUser != null ? Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Tagged Member :',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8.h),
      SizedBox(
        height: 60.h,
        child: AssignedMemberChip(
          imageUrl: taggedUser.imageUrl,
          userName: taggedUser.fullName,
          onDeleted: () {},
        ),
      ),
    ],
  ) : const SizedBox.shrink() ;
}

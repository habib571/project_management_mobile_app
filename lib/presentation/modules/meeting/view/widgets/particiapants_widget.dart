import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/presentation/modules/meeting/viewModels/meeting_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../utils/styles.dart';
import '../../../dashboord/view/screens/members_screen.dart';
import '../../../dashboord/view/widgets/custom_chips/assigned_memberchip.dart';
import '../../../dashboord/viewmodel/project_details_view_models/project_detail_view_model.dart';

class ParticipantsWidget extends StatelessWidget {
  const ParticipantsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final meetingViewModel = context.read<MeetingViewModel>();
    final projectViewModel = context.read<ProjectDetailViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Participants",
              style: robotoBold.copyWith(fontSize: 14),
            ),
            TextButton.icon(
              onPressed: () => () {
                Get.to(() => MembersScreen(), arguments: projectViewModel);
              },
              icon: const Icon(Icons.person_add_alt, size: 18),
              label: const Text("Add"),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Chips
        Consumer<MeetingViewModel>(
            builder: (_, vm, __) {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (var participant in meetingViewModel.participants)
                    AssignedMemberChip(
                        imageUrl: null, // pass avatar if you have it
                        userName: participant.user!.fullName,
                        onDeleted: () {
                          meetingViewModel.removeParticipantId(participant.id!);
                        }),

                  // Add chip
                  ActionChip(
                    label: const Text(" + Add "),
                    avatar: const CircleAvatar(
                      child: Icon(Icons.add, size: 16),
                    ),
                    onPressed: () {
                      Get.to(() => MembersScreen(),
                          arguments: projectViewModel);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(
                          color: Colors.grey.shade400,
                          style: BorderStyle.solid),
                    ),
                  ),
                ],
              );
            })
      ],
    );
  }
}

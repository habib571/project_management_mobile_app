import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/domain/models/meeting.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

import '../screens/video_call_screen.dart';
import 'overlapped_images.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard(
      {super.key, required this.isScheduled, required this.meeting});
  final bool isScheduled;
  final Meeting meeting;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(meeting.title!, style: robotoBold),
                meeting.type == MeetingType.SCHEDULED
                    ? _buildMeetingDateTime(
                        const Icon(Icons.calendar_today), "Feb 12, 2023")
                    : const SizedBox.shrink(),
                meeting.type == MeetingType.SCHEDULED
                    ? _buildMeetingDateTime(
                        const Icon(Icons.access_time_rounded), "10:00 AM")
                    : const SizedBox.shrink(),
                const SizedBox(height: 10,) ,
                _getMeetingType(meeting.status!) ,
                const SizedBox(height: 10,) ,
                SizedBox(

                  width: 150,
                  child: OverlappedImages(
                    users: meeting.participants!.map((e) => e.user!).toList(),

                              ),
                ),

          ],
        ),

            SizedBox(
              width: 100,
              child: CustomButton(
                padding: 5,
                height: 35,
                borderRadius: 17,
                onPressed: () {
                  Get.to(() => const VideoCallScreen());
                },
                text: "Join",
              ),
            )
     ]),
    ));
  }

  Widget _buildMeetingDateTime(Icon icon, String dateTime) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 5),
        Text(dateTime,
            style: robotoRegular.copyWith(color: AppColors.secondaryTxt))
      ],
    );
  }

  Widget _getMeetingType(MeetingStatus status) {
    switch (status) {
      case MeetingStatus.CREATED:
        return _buildMeetingType(MeetingStatus.CREATED, AppColors.primary);
      case MeetingStatus.ONGOING:
        return _buildMeetingType(MeetingStatus.ONGOING, AppColors.secondary);
      case MeetingStatus.ENDED:
        return _buildMeetingType(MeetingStatus.ENDED, Colors.redAccent);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildMeetingType(MeetingStatus status, Color color) {
    return Row(children: [
      CircleAvatar(
        backgroundColor: color,
        radius: 2,
      ),
      const SizedBox(width: 5),
      Text(status.name, style: robotoRegular.copyWith(color: color))
    ]);
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

import '../screens/video_call_screen.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard({super.key, required this.isScheduled});
  final bool isScheduled ;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child:
      Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "client meeting" ,
                    style: robotoBold
                ),
                isScheduled?
                    _buildMeetingDateTime(const Icon(Icons.calendar_today) , "Feb 12, 2023") : const SizedBox.shrink(),
                isScheduled?
                _buildMeetingDateTime(const Icon(Icons.access_time_rounded) , "10:00 AM") : const SizedBox.shrink(),


              ],
            ) ,
            SizedBox(
              width: 100,
              child: CustomButton(
                padding: 5,
                height: 35,
                borderRadius: 17,
                  onPressed: () {
                  Get.to(()=>const VideoCallScreen()) ;
                  },
                  text: "Join" ,

              ),
            )


          ],
        ),
      ),
    );
  }
  Widget _buildMeetingDateTime(Icon icon , String dateTime) {
    return  Row(
      children: [
        icon ,
        const SizedBox(width: 5) ,
        Text(
          dateTime ,
          style: robotoRegular.copyWith(color: AppColors.secondaryTxt)
        )
      ],
    ) ;
  }
}

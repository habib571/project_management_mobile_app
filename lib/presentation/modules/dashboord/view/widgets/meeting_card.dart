
import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard({super.key, required this.isScheduled});
  final bool isScheduled ;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          CustomButton(
              onPressed: () {},
              text: "Join" ,

          )


        ],
      ),
    );
  }
  Widget _buildMeetingDateTime(Icon icon , String dateTime) {
    return  Row(
      children: [
        icon ,
        SizedBox(width: 5) ,
        Text(
          dateTime ,
          style: robotoRegular.copyWith(color: AppColors.secondaryTxt)
        )
      ],
    ) ;
  }
}

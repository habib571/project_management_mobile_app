import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';

import '../../../../sharedwidgets/custom_appbar.dart';
import '../widgets/meeting_card.dart';

class MeetingsScreen extends StatelessWidget {
  const MeetingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding:const EdgeInsets.symmetric(horizontal: 25),
           child: Column(
             children: [
                SizedBox(height: 40.h),
               const CustomAppBar(title: "Meetings"),

               ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                  itemCount: 5,
                   itemBuilder: (context ,index) {
                    return const MeetingCard(isScheduled: true);
                   }
               )
             ],
           ),
        )
    ) ;
  }
}

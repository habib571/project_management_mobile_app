import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/member_listile.dart';

import '../../../../sharedwidgets/custom_appbar.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25.h,
            ),
            const CustomAppBar(title: 'All Members'),
            MemberLisTile() ,
            MemberLisTile()

          ],
        ),
      ),
    ) ;
  }
}

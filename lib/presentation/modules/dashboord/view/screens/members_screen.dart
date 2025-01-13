import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/member_listile.dart';

import '../../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../sharedwidgets/custom_appbar.dart';
import '../../viewmodel/project_detail_view_model.dart';

class MembersScreen extends StatelessWidget {
   MembersScreen({super.key}) ;
  final ProjectDetailViewModel _viewModel = instance<ProjectDetailViewModel>();
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
          ListView.builder(
            itemCount:_viewModel.projectMember.length ,
            shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context ,index) {
                 return MemberLisTile(
                   projectMember: _viewModel.projectMember[index],
                 );
              }
            )
          ],
        ),
      ),
    ) ;
  }
}

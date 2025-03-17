
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/member_listile.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/project_details_view_models/project_detail_view_model.dart';
import 'package:project_management_app/presentation/modules/tasks/viewmodel/manage_task_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../sharedwidgets/custom_appbar.dart';

class MembersScreen extends StatelessWidget {
   MembersScreen({super.key}) ;
  final ProjectDetailViewModel _viewModel = Get.arguments ;
  final ManageTaskViewModel _addTaskViewModel  =  instance.get<ManageTaskViewModel>() ;

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
            Selector<ProjectDetailViewModel,List<ProjectMember>>(
              selector: (context, viewModel) => viewModel.projectMember ,
              builder:  (context, data, child) {
                print("--- Rebuild ---");
                return ListView.builder(
                    itemCount:_viewModel.projectMember.length ,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context ,index) {
                      return MemberLisTile(
                        onTap: (){
                          if(_viewModel.projectMember[index].role !="Manger") {
                            _addTaskViewModel.setProjectMember(_viewModel.projectMember[index]) ;
                          }
                          _addTaskViewModel.toggleIsUserAdded() ;
                          Get.back() ;
                        },
                        projectMember: _viewModel.projectMember[index],
                        viewModel: _viewModel,

                      );
                    }
                );
              }
          )
          ],
        ),
      ),
    ) ;
  }
}

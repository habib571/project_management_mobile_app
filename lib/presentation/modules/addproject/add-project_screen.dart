
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/presentation/modules/home/home_screen.dart';

import '../../../application/dependencyInjection/dependency_injection.dart';
import '../../sharedwidgets/custom_button.dart';
import '../../sharedwidgets/input_text.dart';
import '../../stateRender/state_render_impl.dart';
import '../../utils/colors.dart';
import 'add-project-view-model.dart';

class AddProjectScreen extends StatelessWidget {
   AddProjectScreen({super.key});

   final AddProjectViewModel _viewModel = instance<AddProjectViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffold,
        body:_showBody(context)
    );
  }


  Widget _showBody(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          _appBarSection(),
          SizedBox(
            height: 80.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(
                  height: 140.h,
                ),
                _addProjectNameSection(),
                SizedBox(
                  height: 40.h,
                ),
                _addProjectDesrciprionSection(),
                SizedBox(
                  height: 40.h,
                ),
                _addProjectEndDateSection(context),
                SizedBox(
                  height: 60.h,
                ),
                _showButton()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _addProjectNameSection(){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      controller: _viewModel.projectName,
      hintText: "Enter The project name",
    );
  }

  Widget _addProjectDesrciprionSection(){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      controller: _viewModel.projectDescription,
      hintText: "Enter The project description",
      maxLines: 3,
    );
  }

  Widget _addProjectEndDateSection(BuildContext context){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      controller: _viewModel.projectEndDate,
      hintText: "Enter The project end date",
      suffixIcon:const  Icon(Icons.calendar_month_outlined),
      onTap: () async {
        await _viewModel.pickProjectEndDate(context);
      },
    );
  }

  Widget _appBarSection(){
    return Container(
      height: 90.h,
      color: AppColors.primary,
      child: Column(
        children: [
          SizedBox(height: 35.h,),
          Row(
            children: [
               SizedBox(width: 8.w),
              IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: (){
                    Get.off(() => HomeNavBar(), transition: Transition.upToDown);
                  }
              ),
              SizedBox(width: 90.w),
              const Text(
                'Add Project',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

   Widget _showButton() {
     return CustomButton(
         onPressed: () {},
         text: 'Add the project');
   }
}








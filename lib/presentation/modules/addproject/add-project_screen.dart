
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';

import '../../sharedwidgets/custom_button.dart';
import '../../sharedwidgets/input_text.dart';
import '../../stateRender/state_render_impl.dart';
import '../../utils/colors.dart';

class AddProjectScreen extends StatelessWidget {
   AddProjectScreen({super.key});


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
      //controller: _viewModel.email,
      hintText: "Enter The project name",
    );
  }

  Widget _addProjectDesrciprionSection(){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      //controller: _viewModel.email,
      hintText: "Enter The project description",
      maxLines: 15,
    );
  }

  Widget _addProjectEndDateSection(BuildContext context){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      hintText: "Enter The project end date",
      onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {}
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
              const Text(
                'Add Project',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Spacer(),
              IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: (){}
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








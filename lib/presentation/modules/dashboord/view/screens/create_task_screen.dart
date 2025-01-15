import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/presentation/modules/addproject/view/add-project_screen.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';

import '../../../../sharedwidgets/custom_button.dart';
import '../../../../sharedwidgets/input_text.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
         child: _showBody(context),
       ),
    ) ;
  }
  Widget _showBody(BuildContext context) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.h,
            ),
            const CustomAppBar(title: 'Add Task'),
            SizedBox(height: 30.h) ,
            _taskNameSection() ,
            SizedBox(height: 30.h) ,
            _descriptionSection() ,
            SizedBox(height: 30.h) ,
            _deadlineSection(context),
            SizedBox(height: 30.h) ,
            _showButton()


          ],
        ),
      );
  }
  Widget _taskNameSection(){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      controller: TextEditingController() ,
      hintText: "Enter The project name",
    );
  }
  Widget _descriptionSection(){
    return InputText(
      borderRadius: 15,
      validator: (val) => val.isEmptyInput() ,
      controller: TextEditingController() ,
      hintText: "Enter The Task description",
      maxLines: 3,
    );
  }

  Widget _deadlineSection(BuildContext context){
    return InputText(
      readOnly: true,
      validator: (val) => val.isEmptyInput() ,
      controller: TextEditingController() ,
      hintText: " Choose Task Deadline",
      suffixIcon:const  Icon(Icons.calendar_month_outlined),
      onTap: () async {
       // await _viewModel.pickProjectEndDate(context);
      },
    );
  }
  Widget _showButton() {
    return CustomButton(
        onPressed: () {},
        text: 'Add Task'
    );
  }

}

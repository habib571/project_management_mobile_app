import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:project_management_app/presentation/sharedwidgets/input_text.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';


class ReportIssueScreen extends StatelessWidget{
  const ReportIssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showBody(context),
    );
  }



  Widget _showBody(BuildContext context) {
    return Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25.h,),
              const CustomAppBar(title: "Report issue"),
              SizedBox(height: 35.h,),
              _issueInputTextSection(),
              SizedBox(height: 35.h,),
              _issueDescriptionInputTextSection()
            ],
          ),
    ));
  }



  Widget _issueInputTextSection(){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      //controller: ,
      hintText: "Type the issue",
    );
  }

  Widget _issueDescriptionInputTextSection(){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      //controller: ,
      hintText: "Enter the issue description",
      maxLines: 3,
    );
  }


}
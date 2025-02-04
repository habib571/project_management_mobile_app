import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/modules/tasks/view/screens/task_filtering_screen.dart';
import 'package:project_management_app/presentation/sharedwidgets/input_text.dart';
import 'package:project_management_app/presentation/utils/colors.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
       body: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 25) ,
          child: Column(
            children: [
              SizedBox(height: 40.h,) ,
              _showSearchBar()

            ],
          ),
       )
      ,
    ) ;
  }
  Widget _showSearchBar() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: InputText(

              prefixIcon: const Icon(Icons.search) ,
              hintText: "Enter task name",
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              Get.to(()=>const TaskFilteringScreen()) ;
            },
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18) ,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(10) ,
                  child: Image.asset("assets/filter.png"),
              ),

            ),
          ),
        )
      ],
    ) ;

  }
}

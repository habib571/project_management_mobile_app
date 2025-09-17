import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/modules/meeting/viewModels/meeting_view_model.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../../sharedwidgets/custom_appbar.dart';
import '../../../../stateRender/state_render_impl.dart';
import '../widgets/meeting_card.dart';
import 'create_meeting_screen.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({super.key});

  @override
  State<MeetingsScreen> createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  late final MeetingViewModel _viewModel;

  @override
  void initState() {
    _viewModel = context.read<MeetingViewModel>();
    _viewModel.start();
    super.initState();
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {
            Get.to(() => const CreateMeetingScreen());
          },
          child: const Icon(
            Icons.video_camera_front_outlined, color: Colors.white,),
        ),
        body: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data?.getScreenWidget(
                  context, _showBody(), () {}) ??
                  _showBody();
            }),
      );
    }

    Widget _showBody() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            const CustomAppBar(title: "Meetings"),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _viewModel.meetings.length,
                itemBuilder: (context, index) {
                  return MeetingCard(
                      isScheduled: true, meeting: _viewModel.meetings[index],
                  );
                }
            )
          ],
        ),
      );
    }
  }


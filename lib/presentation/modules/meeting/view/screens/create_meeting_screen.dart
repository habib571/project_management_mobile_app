import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/presentation/modules/meeting/view/widgets/particiapants_widget.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../../../sharedwidgets/custom_appbar.dart';
import '../../../../sharedwidgets/input_text.dart';
import '../../../../utils/styles.dart';
import '../../viewModels/meeting_view_model.dart';

class CreateMeetingScreen extends StatefulWidget {
  const CreateMeetingScreen({super.key});

  @override
  State<CreateMeetingScreen> createState() => _CreateMeetingScreenState();
}

class _CreateMeetingScreenState extends State<CreateMeetingScreen> {
  late MeetingViewModel _viewModel;
  @override
  void initState() {
    _viewModel = Provider.of<MeetingViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showBody(),
    );
  }

  Widget _showBody() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.h,
            ),
            const CustomAppBar(
              title: "Create Meeting",
            ),
            SizedBox(
              height: 30.h,
            ),
             _labelSection("Meeting Title") ,
            _titleSection(),

            SizedBox(
              height: 25.h,
            ),
            _radioButtonSection(),
            SizedBox(
              height: 25.h,
            ),
            _labelSection("Meeting Date & Time"),
            SizedBox(
              height: 25.h,
            ),
            _dateTimeSection() ,
            SizedBox(
              height: 25.h,
            ),
            const ParticipantsWidget() ,
            SizedBox(
              height: 50.h,
            ),
            CustomButton(
              onPressed: () {

              },
              text: "Create Meeting" ,


            )


          ],
        ));
  }

  Widget _titleSection() {
    return InputText(
      validator: (val) => val.isEmptyInput(),
      controller: _viewModel.titleController,
      hintText: "Title",
      borderSide: const BorderSide(color: Colors.black),
    );
  }

  Widget _selectDate(BuildContext context) {
    return InputText(
      readOnly: true,
      validator: (val) => val.isEmptyInput(),
      controller: _viewModel.dateController,
      hintText: "select Date",
      suffixIcon: const Icon(Icons.calendar_month_outlined),
      onTap: () async {
        await _viewModel.pickMeetingDate(context);
      },
      borderSide: const BorderSide(color: Colors.black),
    );
  }

  Widget _selectTime(BuildContext context) {
    return InputText(
      readOnly: true,
      validator: (val) => val.isEmptyInput(),
      controller: _viewModel.timeController,
      hintText: "select Time",
      suffixIcon: const Icon(Icons.calendar_month_outlined),
      onTap: () async {
        await _viewModel.pickMeetingTime(context);
      },
      borderSide: const BorderSide(color: Colors.black),
    );
  }

  Widget _labelSection(String label) {
    return Text(
      label,
      style: robotoBold.copyWith(fontSize: 14),
    );
  }
  Widget _dateTimeSection() {
    return    Selector<MeetingViewModel, bool>(
      selector: (_, vm) => vm.isScheduled,
      builder: (_, isScheduled, __) {
        return Visibility(
          visible: isScheduled,
          child: Column(
            children: [
              _selectDate(context),
              const SizedBox(height: 12),
              _selectTime(context),
            ],
          ),
        );
      },
    );
  }
  Widget _radioButtonSection() {
    return  Selector<MeetingViewModel, bool>(
      selector: (_, vm) => vm.isScheduled,
      builder: (_, isScheduled, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Schedule meeting"),
            Switch(
              value: isScheduled,
              onChanged: (val) {
                _viewModel.toggleSchedule(val);
              },
            ),

          ],
        );
      },
    );
  }
}

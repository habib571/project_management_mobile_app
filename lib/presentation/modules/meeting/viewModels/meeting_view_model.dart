import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/data/network/requests/add_meeting_request.dart';
import 'package:project_management_app/domain/models/meeting.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/dashboard_view_model.dart';
import 'package:project_management_app/presentation/modules/meeting/view/screens/video_call_screen.dart';

import '../../../../domain/repository/meeting_repo.dart';
import '../../../stateRender/state_render.dart';
import '../../../stateRender/state_render_impl.dart';

class MeetingViewModel extends BaseViewModel {
  MeetingViewModel(super.tokenManager, this._meetingRepository, this._dashBoardViewModel);
  @override
  void start() {
    getMeetings();
    super.start();
  }
  final MeetingRepository _meetingRepository;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  final DashBoardViewModel _dashBoardViewModel ;

  String? selectedDate;
  TimeOfDay? selectedTime;

  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  final List<ProjectMember> _participants = [];

  List<ProjectMember> get participants => _participants;

   List<Meeting> _meetings = [];
  List<Meeting> get meetings => _meetings;

  void toggleSchedule(bool value) {
    _isScheduled = value;
    notifyListeners();
  }

  void addParticipant(ProjectMember participant) {
    _participants.add(participant);
    notifyListeners();
  }

  void removeParticipantId(int id) {
    _participants.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  pickMeetingDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      selectedDate = pickedDate.toString();
      dateController.text =
      "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month
          .toString().padLeft(2, '0')}-${pickedDate.year}";
    }
  }

  pickMeetingTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      selectedTime = pickedTime;
      timeController.text =
      "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute
          .toString().padLeft(2, '0')}";
    }
  }

  String? getFinalDateTime() {
    if (selectedDate != null && selectedTime != null) {
      final combined = DateTime(
        DateTime
            .parse(selectedDate!)
            .year,
        DateTime
            .parse(selectedDate!)
            .month,
        DateTime
            .parse(selectedDate!)
            .day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      return combined.toIso8601String().split('.')[0];
    }
    return null;
  }

  List<int> getParticipantIds() {
    return _participants.map((e) => e.id?? 0 ).toList();
  }
  void sortMeetingsByStatus(List<Meeting> meetings) {
    const order = {
      MeetingStatus.ONGOING: 0,
      MeetingStatus.CREATED: 1,
      MeetingStatus.ENDED: 2,
    };

    meetings.sort((a, b) {
      final aRank = order[a.status] ?? 99;
      final bRank = order[b.status] ?? 99;
      return aRank.compareTo(bRank);
    });
  }
  createMeeting() async {
    log("id projet : ${_dashBoardViewModel.project!.id!}") ;
      updateState(LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState));
      (await _meetingRepository.addMeeting(
        AddMeetingRequest(
          title: titleController.text,
          projectId: _dashBoardViewModel.project!.id!,
          participantsIds: getParticipantIds() ,
          type: isScheduled ? MeetingType.SCHEDULED : MeetingType.INSTANT,
          startDateTime: isScheduled ? getFinalDateTime() : null,
        )
      ))
          .fold((failure) {
        updateState(
            ErrorState(StateRendererType.snackbarState, failure.message));
      }, (success) {
    //    dashBoardViewModel.getMyProjects();
        updateState(ContentState());
         if(!isScheduled) {
           Get.to(()=>const VideoCallScreen()) ;
         }
         else {
           Get.back() ;
         }

      });

  }
getMeetings() async {
  updateState(LoadingState(
      stateRendererType: StateRendererType.fullScreenLoadingState));
  (await _meetingRepository.getMeetings(_dashBoardViewModel.project!.id!)).fold((failure) {
    updateState(ErrorState(StateRendererType.snackbarState, failure.message));
  }, (data) {
    _meetings = data  ;
    sortMeetingsByStatus(_meetings) ;
    notifyListeners();
    updateState(ContentState());
  });
}
  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }


}
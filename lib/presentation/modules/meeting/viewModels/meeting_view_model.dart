import 'package:flutter/material.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';

class MeetingViewModel extends BaseViewModel {
  MeetingViewModel(super.tokenManager);

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  String? selectedDate;
  TimeOfDay? selectedTime;

  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  List<ProjectMember> _participants = [];
  List<ProjectMember> get participants => _participants;

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
            "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
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
            "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
      }
    }

    String? getFinalDateTime() {
      if (selectedDate != null && selectedTime != null) {
        final combined = DateTime(
          DateTime.parse(selectedDate!).year,
          DateTime.parse(selectedDate!).month,
          DateTime.parse(selectedDate!).day,
          selectedTime!.hour,
          selectedTime!.minute,
        );
        return combined.toIso8601String().split('.')[0];
        // removes milliseconds → "2025-08-13T15:45:30"
      }
      return null;
    }
  }


import 'package:project_management_app/presentation/base/base_view_model.dart';

import '../../../../domain/models/notification_model.dart';
import '../../../stateRender/state_render_impl.dart';
import '../View/Screens/notfications_historic_screen.dart';

class NotificationsHistoricViewModel extends BaseViewModel{
  NotificationsHistoricViewModel(super.tokenManager);


  final notifications = [
    NotificationModel(
      id: '1',
      title: 'DB Conception',
      description: 'This task is assigned to you, please respect the deadline ',
      projectName: 'App Mobile v2',
      sendDate: DateTime.now().subtract(const Duration(minutes: 15)),
      type: NotificationType.taskAssignment,
      isRead: false,
    ),
    NotificationModel(
      id: '2',
      title: 'Added to a new project',
      description: 'You are a new member in the Refonte Backend project',
      projectName: 'Refonte Backend',
      sendDate: DateTime.now().subtract(const Duration(hours: 3)),
      type: NotificationType.addedToProject,
      isRead: true,
    ),
    NotificationModel(
      id: '3',
      title: 'Eliminated from the project',
      description: 'You are eliminated from the project',
      projectName: 'Data migration',
      sendDate: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.eliminatedFromProject,
      isRead: false,
    ),
    NotificationModel(
      id: '5',
      title: 'General Meeting',
      description: 'Be present a time',
      projectName: 'Spotify App',
      sendDate: DateTime.now().subtract(const Duration(days: 7)),
      type: NotificationType.other,
      isRead: false,
    ),
  ];

}
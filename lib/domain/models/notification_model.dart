

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String projectName;
  final DateTime sendDate;
  final NotificationType type;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.projectName,
    required this.sendDate,
    required this.type,
    required this.isRead,
  });
}

enum NotificationType {
  addedToProject,
  eliminatedFromProject,
  taskAssignment,
  other
}

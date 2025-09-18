
import 'package:flutter/material.dart';

import '../../../../../domain/models/notification_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import 'package:timeago/timeago.dart' as TimeAgo;


class NotificationWidget extends StatelessWidget {
  final String title;
  final String description;
  final String projectName;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NotificationWidget({
    super.key,
    required this.title,
    required this.description,
    required this.projectName,
    required this.timestamp,
    required this.type,
    required this.isRead,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(UniqueKey().toString()),
      direction: DismissDirection.endToStart,
      background: _buildDismissBackground(),
      onDismissed: (_) => onDelete(),
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 15) ,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: isRead
                ? Colors.white
                : AppColors.accent.withOpacity(0.4),
            borderRadius: BorderRadius.circular(17),
            border: Border(
              left: BorderSide(
                color: _getTypeColor(),
                width: 4,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNotificationIcon(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: robotoRegular,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    _buildFooter(),
                  ],
                ),
              ),
              _buildStatusIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _getTypeColor().withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        _getTypeIcon(),
        color: _getTypeColor(),
        size: 20,
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Flexible(
          child: Text(
            title,
            style: isRead ? robotoBold : robotoMedium ,
          ),
        ),
        const Spacer(),
        Text(
            TimeAgo.format(timestamp),
            style: robotoSemiBold.copyWith(fontSize: 10, color: Colors.grey[700])
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Icon(
          Icons.folder_open_outlined,
          size: 14,
          color: Colors.grey,
        ),
        Text(
          projectName,
          style: robotoRegular.copyWith(fontSize: 10, color: Colors.grey[700]),
        ),
        !isRead ?
        const Icon(Icons.fiber_new,color: AppColors.accent ,):
        const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildStatusIndicator() {
    return !isRead
        ? Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.only(left: 8),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
    )
        : const SizedBox.shrink();
  }

  Widget _buildDismissBackground( ) {
    return Container(
      color: Colors.red[800],
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(
        Icons.delete_outline,
        color: Colors.white,
      ),
    );
  }

  // Helper methods
  IconData _getTypeIcon() {
    switch (type) {
      case NotificationType.addedToProject:
        return Icons.person_outline;
      case NotificationType.eliminatedFromProject:
        return Icons.no_accounts_outlined;
      case NotificationType.taskAssignment:
        return Icons.task_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _getTypeColor() {
    switch (type) {
      case NotificationType.taskAssignment:
        return Colors.green;
      case NotificationType.eliminatedFromProject:
        return Colors.orange;
      case NotificationType.addedToProject:
        return Colors.purple;
      default:
        return AppColors.primary;
    }
  }
}
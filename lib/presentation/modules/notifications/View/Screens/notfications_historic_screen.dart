import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';

import '../../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../../domain/models/notification_model.dart';
import '../../../../sharedwidgets/custom_appbar.dart';
import '../../../../stateRender/state_render_impl.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../../ViewModel/notifications_hstoric_viewmodel.dart';
import '../Widgets/notification_widget.dart';

class NotificationsHistoric extends StatelessWidget {
  NotificationsHistoric({super.key});

  final NotificationsHistoricViewModel _viewModel = instance<NotificationsHistoricViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffold,
        body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data
                ?.getScreenWidget(context, _showBody(context), () {}) ??
                _showBody(context);
          },
        ));
  }
  
  Widget _showBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(

        children: [
          SizedBox(height: 60.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Notifications Historic',
                    style: robotoSemiBold.copyWith(fontSize: 28, color: AppColors.primary,)
                ) ,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: _viewModel.notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationWidget(
                      title: _viewModel.notifications[index].title,
                      description: _viewModel.notifications[index].description,
                      projectName: _viewModel.notifications[index].projectName,
                      timestamp: _viewModel.notifications[index].sendDate,
                      type: _viewModel.notifications[index].type,
                      isRead: _viewModel.notifications[index].isRead,
                      onTap: () {},
                      onDelete: () => {},
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ) ,
    );
    }
    
  }





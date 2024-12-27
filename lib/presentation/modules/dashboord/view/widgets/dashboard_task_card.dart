import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

import '../../../../utils/colors.dart';

class DashboardTasCard extends StatelessWidget {
  const DashboardTasCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.orangeAccent ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20 ,vertical: 15) ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Office Project',
              style: robotoMedium.copyWith(color: AppColors.secondaryTxt, fontSize: 13),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                child: Text(
              'adding landing page following new design',
              style: robotoBold.copyWith(fontSize: 14),
            )),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  color: AppColors.primary,
                ),
                Text('12/02/2025',
                    style: robotoMedium.copyWith(color: AppColors.primary))
              ],
            )
          ],
        ),
      ),
    );
  }
}

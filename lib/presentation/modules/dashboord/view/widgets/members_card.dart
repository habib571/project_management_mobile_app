import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class MembersCard extends StatelessWidget {
  const MembersCard({super.key, required this.children});
  final List<Widget> children ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: AppColors.accent.withOpacity(0.5), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(12)
      ),
      child: Wrap(
        alignment: WrapAlignment.start,
        runSpacing: 20,
        spacing: 5,
        children: children
      ) ,
    ) ;
  }
}

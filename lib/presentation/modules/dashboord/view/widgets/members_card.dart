import 'package:flutter/material.dart';

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
        borderRadius: BorderRadius.circular(17)
      ),
      child: Wrap(
        runSpacing: 5,
        spacing: 5,
        children: children
      ) ,
    ) ;
  }
}

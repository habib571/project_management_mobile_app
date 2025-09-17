import 'package:flutter/material.dart';
import 'package:project_management_app/domain/models/user.dart';
import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';

class OverlappedImages extends StatelessWidget {
  const OverlappedImages({super.key, required this.users});
final List<User> users ;
  @override
  Widget build(BuildContext context) {
    return Stack(
       fit: StackFit.loose,
      children: List.generate(users.length, (index) {
        if (index < 3) {
          return Positioned(
            left: index * 25, // controls overlap
            child: ImagePlaceHolder(radius: 15, imageUrl: users[index].imageUrl ??"", fullName: users[index].fullName,)
          );
        } else {
          // last one is "+3" style
          return Positioned(
            left: index * 25,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: Text(
                "+${users.length - 3}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      }),

    );
  }
}

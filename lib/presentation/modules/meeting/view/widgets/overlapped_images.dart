import 'package:flutter/material.dart';
import 'package:project_management_app/domain/models/user.dart';
import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';

class OverlappedImages extends StatelessWidget {
  const OverlappedImages({super.key, required this.users});
  final List<User> users;

  @override
  Widget build(BuildContext context) {
    const overlap = 25.0;
    const maxVisible = 3;

    List<Widget> items = [];

    // Show up to 3 user images
    for (int i = 0; i < users.length && i < maxVisible; i++) {
      items.add(Positioned(
        left: i * overlap,
        child: ImagePlaceHolder(
          radius: 15,
          imageUrl: users[i].imageUrl ?? "",
          fullName: users[i].fullName,
        ),
      ));
    }

    // Add "+N" if more users exist
    if (users.length > maxVisible) {
      items.add(Positioned(
        left: maxVisible * overlap,
        child: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.blue,
          child: Text(
            "+${users.length - maxVisible}",
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ));
    }

    return SizedBox(
      height: 30, // enough space for avatars
      child: Stack(children: items),
    );
  }
}

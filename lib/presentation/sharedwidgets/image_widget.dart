import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';

import '../utils/colors.dart';

class ImagePlaceHolder extends StatelessWidget {
  const ImagePlaceHolder({super.key, required this.radius, required this.imageUrl , this.imgBorder = false, required this.fullName});

 final double radius ;
 final String imageUrl ;
 final bool imgBorder  ;
 final String fullName ;

  @override
  Widget build(BuildContext context) {
    final String letter = (fullName.isNotEmpty || fullName != "Loading..." ? fullName[0] : "?").toUpperCase();

    return CircleAvatar(
      radius: radius ,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            border: imgBorder ? Border.all(color: AppColors.primary,width: 1,) : null,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                Colors.white60,
                BlendMode.overlay,
              ),
            ),
          ),
        ),
        placeholder: (context, url) =>const CircularProgressIndicator(),
        errorWidget: (context, url, error) => Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            color: _getColorFromFirstLetter(letter),
            shape: BoxShape.circle,
            border: imgBorder ? Border.all(color: AppColors.primary, width: 1) : null,
          ),
          alignment: Alignment.center,
          child: Text(
            letter,
            style: TextStyle(
              fontSize: radius * 0.9,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Color _getColorFromFirstLetter(String letter) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.indigo,
      Colors.teal,
      Colors.brown,
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.cyan,
      Colors.pink,
      Colors.amber,
    ];

    int index = letter.codeUnitAt(0) % colors.length;
    return colors[index];
  }

}

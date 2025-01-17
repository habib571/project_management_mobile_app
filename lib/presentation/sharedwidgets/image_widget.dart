import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';

import '../utils/colors.dart';

class ImagePlaceHolder extends StatelessWidget {
  const ImagePlaceHolder({super.key, required this.radius, required this.imageUrl});
 final double radius ;
 final String imageUrl ;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary,width: 2.w,),
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
        //  placeholder: (context, url) =>const LoadingWidget(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

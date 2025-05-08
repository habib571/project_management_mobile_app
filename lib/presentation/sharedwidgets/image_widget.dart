import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';

import '../../application/constants/constants.dart';
import '../../application/helpers/get_storage.dart';
import '../utils/colors.dart';


class ImagePlaceHolder extends StatelessWidget {
  final double radius;
  final String? imageUrl;
  final bool imgBorder;
  final String fullName;

  final LocalStorage _localStorage = instance<LocalStorage>() ;

   ImagePlaceHolder({
    super.key,
    required this.radius,
    required this.imageUrl,
    this.imgBorder = false,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    final String letter = (fullName.isNotEmpty && fullName != "Loading..."
        ? fullName[0]
        : "?").toUpperCase();

    return CircleAvatar(
      radius: radius,
      child: _buildContent(letter),
    );
  }

  Widget _buildContent(String letter) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildInitials(letter);
    }

    final bool isNetworkImage = imageUrl!.startsWith('http');
    final bool isLocalFile = !isNetworkImage;

    if (isLocalFile) {
      return _buildLocalImage(letter);
    } else {
      return _buildNetworkImage(letter);
    }
  }

  Widget _buildLocalImage(String letter) {
    try {
      final file = File(imageUrl!);

      // Vérifie que le fichier existe avant de l'afficher
      if (file.existsSync()) {
        return Container(
          decoration: BoxDecoration(
            border: imgBorder
                ? Border.all(color: AppColors.primary, width: 1)
                : null,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: FileImage(file),
              fit: BoxFit.cover,
            ),
          ),
        );
      } else {
        debugPrint('cant find loc: $imageUrl');
        return _buildNetworkImage(letter);
      }
    } catch (e) {
      debugPrint('Erreur fichier local: $e');
      return _buildInitials(letter);
    }
  }

  Widget _buildNetworkImage(String letter) {
    print("ùùùùùùùùùùùù   ${Constants.baseUrl}/images/$imageUrl");
    return CachedNetworkImage(
      httpHeaders:  {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${_localStorage.getAuthToken()}'
      },
      imageUrl: "${Constants.baseUrl}/images/$imageUrl", //imageUrl!,
      //cacheKey: imageUrl?.split('/').last,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          border: imgBorder
              ? Border.all(color: AppColors.primary, width: 1)
              : null,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) =>_buildInitials(letter)

    );
  }

  Widget _buildInitials(String letter) {
    return Container(
      decoration: BoxDecoration(
        color: _getColorFromFirstLetter(letter),
        shape: BoxShape.circle,
        border: imgBorder
            ? Border.all(color: AppColors.primary, width: 1)
            : null,
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


/*
class ImagePlaceHolder extends StatelessWidget {
  final double radius;
  final String? imageUrl;
  final bool imgBorder;
  final String fullName;

  const ImagePlaceHolder({
    super.key,
    required this.radius,
    required this.imageUrl,
    this.imgBorder = false,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    final String letter = (fullName.isNotEmpty && fullName != "Loading..."
        ? fullName[0]
        : "?"
    ).toUpperCase();

    final bool isLocalFile =  imageUrl.isNotEmpty && !imageUrl.startsWith('http');

    return CircleAvatar(
      radius: radius,
      child: isLocalFile
          ? _buildLocalImage()
          : _buildNetworkImage(letter),
    );
  }

  Widget _buildLocalImage() {
    return Container(
      decoration: BoxDecoration(
        border: imgBorder ? Border.all(color: AppColors.primary, width: 1) : null,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: FileImage(File(imageUrl)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildNetworkImage(String letter) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          border: imgBorder ? Border.all(color: AppColors.primary, width: 1) : null,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => _buildErrorWidget(letter),
    );
  }

  Widget _buildErrorWidget(String letter) {
    return Container(
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

*/


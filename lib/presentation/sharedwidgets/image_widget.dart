import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../application/constants/constants.dart';
import '../utils/colors.dart';


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
      return Container(
        decoration: BoxDecoration(
          border: imgBorder
              ? Border.all(color: AppColors.primary, width: 1)
              : null,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: FileImage(File(imageUrl!)),
            fit: BoxFit.cover,
          ),
        ),
      );
    } catch (e) {
      return _buildInitials(letter);
    }
  }

  Widget _buildNetworkImage(String letter) {
    return CachedNetworkImage(
      httpHeaders: const {
        'Accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ5b3Vzc2VmQGdtYWlsLmNvbSIsImlhdCI6MTczNjY0MDAzOCwiZXhwIjoxNzcyNjQwMDM4fQ.idEqO31qMyred3TZXhhmu8gGjyuLRXCOfgzkVsbQVLs'
      },
      imageUrl: imageUrl!,
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
      errorWidget: (context, url, error) {
        print('Image load error: $error');
        return _buildInitials(letter);
      },
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


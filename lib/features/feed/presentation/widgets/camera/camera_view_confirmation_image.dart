import 'dart:io';
import 'package:colibri/core/extensions/context_exrensions.dart';
import 'package:flutter/material.dart';

class CameraViewConfirmationImage extends StatelessWidget {
  const CameraViewConfirmationImage(this.image, {Key? key}) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.file(
          File(image),
          height: context.getScreenHeight * .7,
          width: context.getScreenWidth * .95,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}

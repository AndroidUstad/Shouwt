import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'camera_view_confirmation_screen_button.dart';

class CameraViewConfirmationBottomRow extends StatelessWidget {
  const CameraViewConfirmationBottomRow({
    Key? key,
    required this.onConfirm,
    required this.isVideo,
  }) : super(key: key);
  final VoidCallback onConfirm;
  final bool isVideo;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CameraViewConfirmationScreenButton(
              text: 'Retake',
              onTap: context.router.pop,
            ),
            CameraViewConfirmationScreenButton(
              text: 'Use ${isVideo ? 'video' : 'photo'}',
              onTap: onConfirm,
            ),
          ],
        ),
      ),
    );
  }
}

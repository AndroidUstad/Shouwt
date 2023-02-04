import 'package:colibri/core/extensions/string_extensions.dart';
import 'package:flutter/services.dart';
import '../../../../../../../core/extensions/context_exrensions.dart';
import '../../../../../../../config/colors.dart';
import '../../../../../../../main.dart';
import 'package:flutter/material.dart';
import 'camera_view_confirmation_bottom_row.dart';
import 'camera_view_confirmation_image.dart';
import 'camera_view_confirmation_video.dart';

class CameraViewConfirmationScreen extends StatefulWidget {
  const CameraViewConfirmationScreen(
    this.image, {
    Key? key,
    required this.onCropped,
  }) : super(key: key);
  final String image;
  final void Function(String)? onCropped;

  @override
  State<CameraViewConfirmationScreen> createState() =>
      _CameraViewConfirmationScreenState();
}

class _CameraViewConfirmationScreenState
    extends State<CameraViewConfirmationScreen> {
  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDark ? AppColors.appBlackColor : Colors.white,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _l = widget.image.split('.');
    bool isVideo = _l.last == 'mp4';
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Stack(
        children: [
          Container(
            height: context.getScreenHeight as double,
            width: context.getScreenWidth as double,
            color: Color.fromRGBO(44, 52, 54, 1),
          ),
          isVideo
              ? CameraViewConfirmationVideo(widget.image)
              : CameraViewConfirmationImage(widget.image),
          CameraViewConfirmationBottomRow(
            onConfirm:
                isVideo ? () => widget.onCropped!(widget.image) : confirmImage,
            isVideo: isVideo,
          ),
        ],
      ),
    );
  }

  void confirmImage() async {
    final compressedFile = await widget.image.compressImage();
    await context.cropImage(
      file: compressedFile,
      onCropped: widget.onCropped!,
    );
    context.popNTimes(3);
  }
}

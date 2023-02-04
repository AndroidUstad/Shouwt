import '../../../../../../extensions.dart';
import '../../../../../core/common/animated_fade_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CameraViewConfirmationScreenButton extends StatelessWidget {
  const CameraViewConfirmationScreenButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeWidget(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: text.toSubTitle2(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 11.sp,
          ),
        ),
      ),
    );
  }
}

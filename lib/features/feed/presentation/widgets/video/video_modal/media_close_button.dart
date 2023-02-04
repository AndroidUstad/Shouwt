import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sized_context/sized_context.dart';
import '../../../../../../core/common/animated_fade_widget.dart';

class MediaCloseButton extends StatelessWidget {
  const MediaCloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeWidget(
      onTap: () => context.router.root.pop(),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        padding: REdgeInsets.all(5),
        child: Icon(
          Icons.close,
          color: Colors.white,
          size: context.isLandscape ? 8.5.sp : 16.sp,
        ),
      ),
    );
  }
}

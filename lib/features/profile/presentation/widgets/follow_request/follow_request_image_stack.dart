import '../../../../../core/extensions/string_extensions.dart';
import '../../../../feed/presentation/widgets/feed_leading_profile_avatar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FollowRequestImageStack extends StatelessWidget {
  const FollowRequestImageStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _circleWidget(0),
        _circleWidget(1),
        _circleWidget(2),
        _circleWidget(3),
        _circleWidget(4),
      ],
    );
  }

  double? _getWidgetBasedOnPosition(int position) =>
      20.w * position == 0 ? null : 20.w * position;

  Widget _circleWidget(int index) {
    return Positioned(
      left: _getWidgetBasedOnPosition(index),
      child: Container(
        height: 30,
        width: 30,
        child: defaultAvatar.toRoundNetworkImage(),
      ),
    );
  }
}

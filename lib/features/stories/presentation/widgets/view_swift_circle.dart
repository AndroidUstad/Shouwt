import 'package:auto_route/auto_route.dart';
import 'package:colibri/core/common/animated_fade_widget.dart';
import 'package:colibri/core/datasource/local_data_source.dart';
import 'package:colibri/core/routes/routes.gr.dart';
import 'package:colibri/features/stories/domain/models/response/get_swifts_list_response/datum.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../config/colors.dart';
import '../../../../../extensions.dart';
import 'package:flutter/material.dart';
import '../../../../core/di/injection.dart';
import '../../../../main.dart';

class ViewSwiftCircle extends StatelessWidget {
  const ViewSwiftCircle(this.swift, {Key? key}) : super(key: key);
  final Datum swift;
  @override
  Widget build(BuildContext context) {
    bool isMe = swift.username! ==
        getIt<LocalDataSource>().getUserData()!.data!.user!.userName;
    bool isSeen = true;
    swift.swift!.forEach((story) {
      if (story.seen == 0) isSeen = false;
    });
    return Container(
      width: 80.w,
      child: Column(
        children: [
          AnimatedFadeWidget(
            onTap: () =>
                context.router.push(ViewStoryScreenRoute(swift: swift)),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSeen
                      ? Color.fromRGBO(213, 223, 230, .7)
                      : Colors.blue.withOpacity(.7),
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              padding: REdgeInsets.all(2),
              child: swift.avatar!.toRoundNetworkImage(radius: 10.r),
            ),
          ),
          5.toSizedBox,
          Center(
            child: Text(
              isMe ? 'Your Swifts' : swift.username!,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.caption.copyWith(
                fontSize: 11.sp,
                color: isDark ? Colors.white : AppColors.textColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
              ),
            ),
          ),
        ],
      ),
    ).toVisibility(swift.swift!.length > 0);
  }
}

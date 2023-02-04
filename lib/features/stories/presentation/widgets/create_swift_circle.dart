import 'package:auto_route/auto_route.dart';
import 'package:colibri/core/datasource/local_data_source.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../../core/theme/app_icons.dart';
import '../../../../../extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/routes.gr.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../main.dart';

class CreateSwiftCircle extends StatelessWidget {
  const CreateSwiftCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = getIt<LocalDataSource>().getUserData();
    return GestureDetector(
      onTap: () => context.router.push(SelectMediaForStoryScreenRoute()),
      child: Container(
        width: 80.w,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(213, 223, 230, .7),
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  padding: REdgeInsets.all(2),
                  child: currentUser!.data!.user!.profilePicture!
                      .toRoundNetworkImage(radius: 10.r),
                ),
                Positioned(
                  right: 0.0,
                  bottom: 0.0,
                  child: AppIcons.swiftAddIcon,
                )
              ],
            ),
            5.toSizedBox,
            Center(
              child: Text(
                'Create',
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
      ),
    );
  }
}

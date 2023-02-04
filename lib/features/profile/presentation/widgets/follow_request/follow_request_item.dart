import '../../../../../core/routes/routes.gr.dart';
import '../../../../../core/theme/app_icons.dart';
import '../../../../../extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/colors.dart';
import '../../../../../main.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../domain/entity/pagination/fetch_follow_requests_item.dart';
import '../../bloc/followers_following_cubit.dart';
import '../profile_user_stats_bar_item.dart';

class FollowRequestItem extends StatelessWidget {
  const FollowRequestItem(this.item, {Key? key}) : super(key: key);
  final FetchFollowRequestsItem item;
  @override
  Widget build(BuildContext context) {
    final _followCubit = BlocProvider.of<FollowersFollowingCubit>(context);
    return GestureDetector(
      onTap: () =>
          appRouter.push(ProfileScreenRoute(otherUserId: item.id.toString())),
      child: Padding(
        padding: REdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  item.avatar!.toRoundNetworkImage(),
                  10.toSizedBoxHorizontal,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            item.name!.toSubTitle2(
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            5.toSizedBoxHorizontal,
                            '@${item.username!}'
                                .toSubTitle2(color: AppColors.greyText),
                          ],
                        ), //

                        // Row(
                        //   children: [
                        //     Images.profileCounry
                        //         .toSvg(color: AppColors.optionIconColor),
                        //     5.toSizedBoxHorizontal,
                        //     LocaleKeys.living_in.tr(namedArgs: {
                        //       '@conutry_name@': 'United States'
                        //     }).toSubTitle2()
                        //   ],
                        // ),
                        Row(
                          children: [
                            ProfileUserStatsBarItem(
                              number: item.posts!.toString(),
                              text: LocaleKeys.posts.tr(),
                              function: () {},
                            ),
                            // Padding(
                            //   padding: REdgeInsets.symmetric(horizontal: 8.0),
                            //   child: ProfileUserStatsBarItem(
                            //     number: 'x',
                            //     text: LocaleKeys.following.tr(),
                            //     function: () {},
                            //   ),
                            // ),
                            // ProfileUserStatsBarItem(
                            //   number: 'x',
                            //   text: LocaleKeys.followers.tr(),
                            //   function: () {},
                            // ),
                            //   ],
                            //    ),
                            // 30.toSizedBox,
                            // 'Has 121 followers you know'.toSubTitle2(
                            //   color: Color.fromRGBO(7, 134, 214, 1),
                            //   fontWeight: FontWeight.bold,
                            // ),
                            // 10.toSizedBox,
                            // Row(
                            //   children: [
                            //     Container(
                            //       width: 115.w,
                            //       child: FollowRequestImageStack(),
                            //     ),
                            //     Container(
                            //       child: '+116'.toSubTitle2(
                            //         color: Color.fromRGBO(7, 134, 214, 1),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0, -10, 0),
              child: Theme(
                data: Theme.of(context).copyWith(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
                child: [item.name!, 'Accept request', 'Delete request']
                    .toPopUpMenuButton(
                  (choice) => _mapChoiceToFunction(choice, _followCubit),
                  icon: Icon(Icons.more_horiz, color: Colors.grey),
                  rowIcon: _mapChoiceToIcon,
                  backGroundColor: _mapChocieToColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _mapChocieToColor(String choice) {
    if (choice == 'Delete request') return Colors.red;
    return Colors.white;
  }

  void _mapChoiceToFunction(String? choice, FollowersFollowingCubit cubit) {
    if (choice == item.name) {
      appRouter.push(ProfileScreenRoute(otherUserId: item.id.toString()));
    } else if (choice == 'Accept request') {
      cubit.acceptFollowRequest(item.id!);
    } else if (choice == 'Delete request') {
      cubit.declineFollowRequest(item.id!);
    }
  }

  Widget _mapChoiceToIcon(String choice) {
    if (choice == item.name) {
      return Icon(
        Icons.person_pin_outlined,
        size: 18.r,
        color: Colors.grey,
      );
    } else if (choice == 'Accept request') {
      return Icon(
        Icons.verified_outlined,
        size: 18.r,
        color: Colors.grey,
      );
    } else if (choice == 'Delete request') {
      return AppIcons.deleteOption(
        color: Colors.red,
        height: 18.h,
        width: 18.w,
      );
    }
    return AppIcons.verifiedIcons;
  }
}

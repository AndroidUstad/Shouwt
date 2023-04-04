import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/colors.dart';
import '../../../../main.dart';
import 'drawer_list_tile.dart';
import 'drawer_properties.dart';
import '../../../../core/common/widget/common_divider.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../../core/constants/appconstants.dart';
import '../../../../core/routes/routes.gr.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../config/strings.dart';
import '../bloc/feed_cubit.dart';
import 'all_home_screens.dart';
import '../../../profile/domain/entity/profile_entity.dart';
import '../../../profile/presentation/pages/followers_following_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../extensions.dart';
import 'package:easy_localization/easy_localization.dart';

class GetDrawerMenu extends StatefulWidget {

  final ProfileEntity? profileEntity;

  const GetDrawerMenu({Key? key, this.profileEntity}) : super(key: key);

  @override
  _GetDrawerMenuState createState() => _GetDrawerMenuState();
}

class _GetDrawerMenuState extends State<GetDrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: !context.isArabic()
            ? const EdgeInsets.only(top: 20.0, left: 15)
            : const EdgeInsets.only(top: 20.0, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.profileEntity!.profileUrl!
                .toRoundNetworkImage(radius: 17)
                .onTapWidget(() {
              Navigator.of(context).pop();
              context.router.root.push(ProfileScreenRoute());
            }),
            SizedBox(height: AC.getDeviceHeight(context) * 0.005),
            Row(
              children: [
                widget.profileEntity!.fullName.toSubTitle1(
                  (url) =>
                      context.router.root.push(WebViewScreenRoute(url: url)),
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily1: "Poppins",
                  fontSize: AC.getDeviceHeight(context) * 0.03,
                ),
                AppIcons.verifiedIcons
                    .toContainer()
                    .toVisibility(widget.profileEntity!.isVerified!),
              ],
            ),
            2.toSizedBox,
            Text(
              widget.profileEntity!.userName,
              style: TextStyle(
                fontSize: AC.getDeviceHeight(context) * 0.02,
                color: Color(0xFF737880),
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
              ),
            ),
            20.toSizedBox,
            Row(
              children: [
                DrawerProperties(
                  number: widget.profileEntity!.followingCount,
                  text: LocaleKeys.following.tr(),
                  function: () {
                    Navigator.of(context).pop();
                    context.router.root.push(
                      FollowingFollowersScreenRoute(
                        followScreenEnum: FollowUnFollowScreenEnum.FOLLOWING,
                        profileEntity: widget.profileEntity!,
                      ),
                    );
                  },
                ),
                10.toSizedBoxHorizontal,
                DrawerProperties(
                  number: widget.profileEntity!.followerCount,
                  text: LocaleKeys.followers.tr(),
                  function: () {
                    Navigator.of(context).pop();
                    context.router.root.push(
                      FollowingFollowersScreenRoute(
                        followScreenEnum: FollowUnFollowScreenEnum.FOLLOWERS,
                        profileEntity: widget.profileEntity!,
                      ),
                    );
                  },
                ),
              ],
            ),
            20.toSizedBox,
            commonDivider,
            20.toSizedBox,
            Expanded(
              child: Column(
                children: [
                  DrawerListTile(
                    icon: AppIcons.drawerProfile1(
                      color: isDark ? Colors.white : null,
                    ),
                    text: LocaleKeys.profile.tr(),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.router.root.push(ProfileScreenRoute());
                    },
                  ),
                  30.toSizedBox,
                  DrawerListTile(
                    icon: AppIcons.drawerBookmark1(
                      color: isDark ? Colors.white : null,
                    ),
                    text: LocaleKeys.bookmarks.tr(),
                    onTap: () {
                      Navigator.of(context).pop();
                      BlocProvider.of<FeedCubit>(context)
                          .changeCurrentPage(const ScreenType.bookmarks());
                    },
                  ),
                  30.toSizedBox,
                  DrawerListTile(
                    icon: AppIcons.drawerEarnTokens(
                      color: isDark ? Colors.white : null,
                    ),
                    text: LocaleKeys.earnToken.tr(),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.router.root.push(
                        WebViewScreenRoute(
                          url: Strings.earnTokeLink,
                          name: Strings.earnTokens,
                        ),
                      );
                    },
                  ),
                  30.toSizedBox,
                  DrawerListTile(
                    icon: AppIcons.drawerFreeSpeechTokens(
                      color: isDark ? Colors.white : null,
                    ),
                    text: LocaleKeys.freeTokens.tr(),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.router.root.push(
                        WebViewScreenRoute(
                          url: Strings.freeSpeechTokenLink,
                          name: Strings.freeSpeechTokens,
                        ),
                      );
                    },
                  ),
                  30.toSizedBox,
                  DrawerListTile(
                    icon: AppIcons.drawerAdvertising(
                      color: isDark ? Colors.white : null,
                    ),
                    text: LocaleKeys.advertising.tr(),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.router.root.push(
                        WebViewScreenRoute(
                          url: Strings.adsShow,
                          name: Strings.ads,
                        ),
                      );
                    },
                  ),
                  30.toSizedBox,
                  DrawerListTile(
                    icon: AppIcons.drawerAffiliates(
                      color: isDark ? Colors.white : null,
                    ),
                    text: LocaleKeys.affiliates.tr(),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.router.root.push(
                        WebViewScreenRoute(
                          url: Strings.affiliates,
                          name: Strings.affiliatesStr,
                        ),
                      );
                    },
                  ),
                  30.toSizedBox,
                  Spacer(),
                  DrawerListTile(
                    icon: Container(
                      child: AppIcons.signOut(
                        color: isDark ? Colors.white : null,
                      ),
                      transform: Matrix4.translationValues(2.0, 0, 0),
                    ),
                    text: LocaleKeys.logout.tr(),
                    onTap: () {
                      context.showAlertDialog(
                        widgets: [
                          "Yes"
                              .toButton(
                                  color: isDark
                                      ? AppColors.colorPrimary
                                      : AppColors.textColor)
                              .toFlatButton(
                                () => BlocProvider.of<FeedCubit>(context)
                                    .logout(),
                              ),
                          "No"
                              .toButton(
                                  color: isDark
                                      ? AppColors.colorPrimary
                                      : AppColors.textColor)
                              .toFlatButton(
                                () => context.router.root.pop(),
                              ),
                        ],
                        title: LocaleKeys
                            .are_you_sure_that_you_want_to_log_out_from_your_account
                            .tr(),
                      );
                    },
                  ),
                  15.toSizedBox,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

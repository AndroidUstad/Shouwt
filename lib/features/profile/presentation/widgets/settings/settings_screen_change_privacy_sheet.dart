import '../../../../../core/extensions/context_exrensions.dart';
import '../../../../../core/extensions/string_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../main.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../domain/entity/response/get_privacy_settings_response/get_privacy_settings_response.dart';

class SettingsScreenChangePrivacySheet extends StatefulWidget {
  const SettingsScreenChangePrivacySheet(this.data, {Key? key})
      : super(key: key);
  final GetPrivacySettingsResponse data;
  @override
  State<SettingsScreenChangePrivacySheet> createState() =>
      _SettingsScreenChangePrivacySheetState();
}

class _SettingsScreenChangePrivacySheetState
    extends State<SettingsScreenChangePrivacySheet> {
  late String whoCanSeeMyPosts;
  late String whoCanFollowMe;
  late String whoCanDirectMessageMe;
  late String showProfile;

  @override
  void initState() {
    super.initState();
    whoCanSeeMyPosts = widget.data.data!.profileVisibility!;
    whoCanFollowMe = widget.data.data!.followPrivacy ?? 'everyone';
    whoCanDirectMessageMe = widget.data.data!.contactPrivacy!;
    showProfile = widget.data.data!.searchVisibility! ? 'yes' : 'no';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: REdgeInsets.symmetric(vertical: 8.0),
          child: SmartSelect<String?>.single(
            choiceStyle: S2ChoiceStyle(
              titleStyle: context.subTitle2.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            modalConfig: S2ModalConfig(
              title: LocaleKeys.who_can_see_my_profile_posts.tr(),
              headerStyle: S2ModalHeaderStyle(
                textStyle:
                    TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
            ),
            modalType: S2ModalType.bottomSheet,
            selectedValue: whoCanSeeMyPosts,
            onChange: (s) {
              setState(() {
                whoCanSeeMyPosts = s.value!;
              });
            },
            tileBuilder: (c, s) => InkWell(
              onTap: s.showModal,
              child: ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 14,
                ),
                title: LocaleKeys.who_can_see_my_profile_posts
                    .tr()
                    .toSubTitle2(fontWeight: FontWeight.w500),
                subtitle:
                    whoCanSeeMyPosts.toCaption(fontWeight: FontWeight.w500),
              ),
            ),
            choiceItems:
                [LocaleKeys.everyone.tr(), LocaleKeys.my_followers.tr()]
                    .toList()
                    .map(
                      (e) => S2Choice(
                        value: e,
                        title: e,
                        style: S2ChoiceStyle(
                          titleStyle: TextStyle(
                              color: isDark ? Colors.white : Colors.black),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
        Padding(
          padding: REdgeInsets.symmetric(vertical: 8.0),
          child: SmartSelect<String?>.single(
            choiceStyle: S2ChoiceStyle(
              titleStyle: context.subTitle2.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            modalConfig: S2ModalConfig(
              title: LocaleKeys.who_can_follow_me.tr(),
              headerStyle: S2ModalHeaderStyle(
                textStyle:
                    TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
            ),
            modalType: S2ModalType.bottomSheet,
            selectedValue: whoCanFollowMe,
            onChange: (s) {
              setState(() {
                whoCanFollowMe = s.value!;
              });
            },
            tileBuilder: (c, s) => InkWell(
              onTap: s.showModal,
              child: ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 14,
                ),
                title: LocaleKeys.who_can_follow_me
                    .tr()
                    .toSubTitle2(fontWeight: FontWeight.w500),
                subtitle: whoCanFollowMe.toCaption(fontWeight: FontWeight.w500),
              ),
            ),
            choiceItems:
                [LocaleKeys.everyone.tr(), LocaleKeys.approved_users_only.tr()]
                    .toList()
                    .map(
                      (e) => S2Choice(
                        value: e,
                        title: e,
                        style: S2ChoiceStyle(
                          titleStyle: TextStyle(
                              color: isDark ? Colors.white : Colors.black),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
        Padding(
          padding: REdgeInsets.symmetric(vertical: 8.0),
          child: SmartSelect<String?>.single(
            choiceStyle: S2ChoiceStyle(
              titleStyle: context.subTitle2.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            modalConfig: S2ModalConfig(
              title: LocaleKeys.who_can_direct_message_me.tr(),
              headerStyle: S2ModalHeaderStyle(
                textStyle:
                    TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
            ),
            modalType: S2ModalType.bottomSheet,
            selectedValue: whoCanDirectMessageMe,
            onChange: (s) {
              setState(() {
                whoCanDirectMessageMe = s.value!;
              });
            },
            tileBuilder: (c, s) => InkWell(
              onTap: s.showModal,
              child: ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 14,
                ),
                title: LocaleKeys.who_can_direct_message_me
                    .tr()
                    .toSubTitle2(fontWeight: FontWeight.w500),
                subtitle: whoCanDirectMessageMe.toCaption(
                    fontWeight: FontWeight.w500),
              ),
            ),
            choiceItems:
                [LocaleKeys.everyone.tr(), LocaleKeys.the_people_i_follow.tr()]
                    .toList()
                    .map(
                      (e) => S2Choice(
                        value: e,
                        title: e,
                        style: S2ChoiceStyle(
                          titleStyle: TextStyle(
                              color: isDark ? Colors.white : Colors.black),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
        Padding(
          padding: REdgeInsets.symmetric(vertical: 8.0),
          child: SmartSelect<String?>.single(
            choiceStyle: S2ChoiceStyle(
              titleStyle: context.subTitle2.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            modalConfig: S2ModalConfig(
              title: LocaleKeys.show_your_profile_in_search_engines.tr(),
              headerStyle: S2ModalHeaderStyle(
                textStyle:
                    TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
            ),
            modalType: S2ModalType.bottomSheet,
            selectedValue: showProfile,
            onChange: (s) {
              showProfile = s.value!;
            },
            tileBuilder: (c, s) => InkWell(
              onTap: s.showModal,
              child: ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 14,
                ),
                title: LocaleKeys.show_your_profile_in_search_engines
                    .tr()
                    .toSubTitle2(fontWeight: FontWeight.w500),
                subtitle: showProfile.toCaption(fontWeight: FontWeight.w500),
              ),
            ),
            choiceItems: [LocaleKeys.yes.tr(), LocaleKeys.no.tr()]
                .toList()
                .map(
                  (e) => S2Choice(
                    value: e,
                    title: e,
                    style: S2ChoiceStyle(
                      titleStyle: TextStyle(
                          color: isDark ? Colors.white : Colors.black),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

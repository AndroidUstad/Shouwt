import '../../../../../extensions.dart';
import '../../../data/models/response/get_profile_settings_response/data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/colors.dart';
import '../../../../../config/strings.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../bloc/settings/user_setting_cubit.dart';

class SettingsScreenChangeWebsiteSheet extends StatefulWidget {
  const SettingsScreenChangeWebsiteSheet(this.user, {Key? key})
      : super(key: key);
  final Data user;

  @override
  State<SettingsScreenChangeWebsiteSheet> createState() =>
      _SettingsScreenChangeWebsiteSheetState();
}

class _SettingsScreenChangeWebsiteSheetState
    extends State<SettingsScreenChangeWebsiteSheet> {
  late final UserSettingCubit _userSettingCubit;

  @override
  void initState() {
    super.initState();
    _userSettingCubit = BlocProvider.of<UserSettingCubit>(context);

    _userSettingCubit.websiteController =
        TextEditingController(text: widget.user.website);
  }

  @override
  void dispose() {
    _userSettingCubit.websiteController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return [
      11.toSizedBox,
      Strings.userSiteUrl
          .toTextField(controller: _userSettingCubit.websiteController),
      11.toSizedBox,
      LocaleKeys
          .please_note_that_this_url_will_appear_on_your_profile_page_if_you
          .tr()
          .toCaption(
            fontWeight: FontWeight.w500,
            color: AppColors.colorPrimary,
            maxLines: 5,
          )
          .toFlexible()
    ].toColumn();
  }
}

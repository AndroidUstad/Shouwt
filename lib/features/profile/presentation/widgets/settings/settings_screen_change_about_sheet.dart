import '../../../../../extensions.dart';
import '../../../data/models/response/get_profile_settings_response/data.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/colors.dart';
import '../../../../../config/strings.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../bloc/settings/user_setting_cubit.dart';

class SettingsScreenChangeAboutSheet extends StatefulWidget {
  const SettingsScreenChangeAboutSheet(this.user, {Key? key}) : super(key: key);
  final Data user;

  @override
  State<SettingsScreenChangeAboutSheet> createState() =>
      _SettingsScreenChangeAboutSheetState();
}

class _SettingsScreenChangeAboutSheetState
    extends State<SettingsScreenChangeAboutSheet> {
  late final UserSettingCubit _userSettingCubit;

  @override
  void initState() {
    super.initState();
    _userSettingCubit = BlocProvider.of<UserSettingCubit>(context);
    _userSettingCubit.aboutYouController =
        TextEditingController(text: widget.user.aboutYou);
  }

  @override
  void dispose() {
    _userSettingCubit.aboutYouController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return [
      11.toSizedBox,
      Strings.aboutYou.toTextField(
        maxLength: 140,
        controller: _userSettingCubit.aboutYouController,
      ),
      11.toSizedBox,
      LocaleKeys
          .please_enter_a_brief_description_of_yourself_with_a_maximum_of_14
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

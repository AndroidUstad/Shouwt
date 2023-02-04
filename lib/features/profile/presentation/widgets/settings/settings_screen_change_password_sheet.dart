import '../../../../../extensions.dart';
import '../../../data/models/response/get_profile_settings_response/data.dart';
import '../../bloc/settings/user_setting_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/colors.dart';
import '../../../../../config/strings.dart';
import '../../../../../translations/locale_keys.g.dart';

class SettingsScreenChangePasswordSheet extends StatefulWidget {
  const SettingsScreenChangePasswordSheet(this.user, {Key? key})
      : super(key: key);
  final Data user;
  @override
  State<SettingsScreenChangePasswordSheet> createState() =>
      _SettingsScreenChangePasswordSheetState();
}

class _SettingsScreenChangePasswordSheetState
    extends State<SettingsScreenChangePasswordSheet> {
  late final UserSettingCubit _userSettingCubit;
  @override
  void initState() {
    super.initState();
    _userSettingCubit = BlocProvider.of<UserSettingCubit>(context);
    _userSettingCubit.currentPasswordController = TextEditingController();
    _userSettingCubit.newPasswordController = TextEditingController();
    _userSettingCubit.confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _userSettingCubit.currentPasswordController?.dispose();
    _userSettingCubit.newPasswordController?.dispose();
    _userSettingCubit.confirmPasswordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return [
      11.toSizedBox,
      Strings.currentPassword
          .toTextField(controller: _userSettingCubit.currentPasswordController),
      11.toSizedBox,
      Strings.newPassword
          .toTextField(controller: _userSettingCubit.newPasswordController),
      11.toSizedBox,
      Strings.confirmNewPassword
          .toTextField(controller: _userSettingCubit.confirmPasswordController),
      11.toSizedBox,
      LocaleKeys
          .before_changing_your_current_password_please_follow_these_tips_in
          .tr()
          .toCaption(
              fontWeight: FontWeight.w500,
              color: AppColors.colorPrimary,
              maxLines: 5)
          .toFlexible()
    ].toColumn();
  }
}

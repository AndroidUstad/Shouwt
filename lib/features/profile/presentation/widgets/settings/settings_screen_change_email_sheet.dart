import '../../../../../extensions.dart';
import '../../../data/models/response/get_profile_settings_response/data.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/colors.dart';
import '../../../../../config/strings.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../bloc/settings/user_setting_cubit.dart';

class SettingsScreenChangeEmailSheet extends StatefulWidget {
  const SettingsScreenChangeEmailSheet(this.user, {Key? key}) : super(key: key);
  final Data user;
  @override
  State<SettingsScreenChangeEmailSheet> createState() =>
      _SettingsScreenChangeEmailSheetState();
}

class _SettingsScreenChangeEmailSheetState
    extends State<SettingsScreenChangeEmailSheet> {
  late final UserSettingCubit _userSettingCubit;
  @override
  void initState() {
    super.initState();
    _userSettingCubit = BlocProvider.of<UserSettingCubit>(context);
    _userSettingCubit.emailController =
        TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _userSettingCubit.emailController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        11.toSizedBox,
        Strings.emailAddress
            .toTextField(controller: _userSettingCubit.emailController),
        11.toSizedBox,
        LocaleKeys
            .please_note_that_after_changing_the_email_address_the_email_addre
            .tr()
            .toCaption(
              fontWeight: FontWeight.w500,
              color: AppColors.colorPrimary,
              maxLines: 5,
            )
      ],
    );
  }
}

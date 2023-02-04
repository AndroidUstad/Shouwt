import '../../../../../extensions.dart';
import '../../bloc/settings/user_setting_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/colors.dart';
import '../../../../../config/strings.dart';
import '../../../../../translations/locale_keys.g.dart';

class SettingsScreenDeleteAccountSheet extends StatelessWidget {
  const SettingsScreenDeleteAccountSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userSettingCubit = BlocProvider.of<UserSettingCubit>(context);
    return [
      11.toSizedBox,
      Strings.password
          .toTextField(controller: _userSettingCubit.deleteAccountPassword),
      11.toSizedBox,
      LocaleKeys
          .please_note_that_after_deleting_your_account_all_your_publication
          .tr()
          .toCaption(
              fontWeight: FontWeight.w500,
              color: AppColors.colorPrimary,
              maxLines: 5)
          .toFlexible()
    ].toColumn();
  }
}

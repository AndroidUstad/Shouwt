import '../../../../../extensions.dart';
import '../../bloc/settings/user_setting_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/colors.dart';
import '../../../../../config/strings.dart';
import '../../../../../core/widgets/media_picker.dart';
import '../../../../../main.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../../feed/presentation/widgets/create_post_card.dart';

class SettingsScreenVerifyAccount extends StatefulWidget {
  const SettingsScreenVerifyAccount({Key? key}) : super(key: key);

  @override
  State<SettingsScreenVerifyAccount> createState() =>
      _SettingsScreenVerifyAccountState();
}

class _SettingsScreenVerifyAccountState
    extends State<SettingsScreenVerifyAccount> {
  late final UserSettingCubit _userSettingCubit;
  @override
  void initState() {
    super.initState();
    _userSettingCubit = BlocProvider.of<UserSettingCubit>(context);
    _userSettingCubit.verifyFullName = TextEditingController();
    _userSettingCubit.verifyMessage = TextEditingController();
  }

  @override
  void dispose() {
    _userSettingCubit.verifyFullName?.dispose();
    _userSettingCubit.verifyMessage?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return [
      11.toSizedBox,
      Strings.fullName
          .toTextField(controller: _userSettingCubit.verifyFullName),
      11.toSizedBox,
      Strings.messageToReceiver
          .toTextField(controller: _userSettingCubit.verifyMessage),
      15.toSizedBox,
      LocaleKeys.video_message.tr().toSubTitle2(fontWeight: FontWeight.w500),
      5.toSizedBox,
      LocaleKeys.please_select_a_video_appeal_to_the_reviewer
          .tr()
          .toSubTitle2(align: TextAlign.center)
          .toPadding(18)
          .toContainer(
              color: isDark ? AppColors.greyText : AppColors.sfBgColor,
              alignment: Alignment.center)
          .onTapWidget(
        () async {
          await openMediaPicker(context, (media) {
            if (media != null && media.isNotEmpty)
              _userSettingCubit.videoMessage = media;
          }, mediaType: MediaTypeEnum.VIDEO);
        },
      ),
      15.toSizedBox,
      LocaleKeys
          .please_note_that_this_material_will_not_be_published_or_shared_wi
          .tr()
          .toCaption(
              fontWeight: FontWeight.w500,
              color: AppColors.colorPrimary,
              maxLines: 10)
          .toFlexible()
    ].toColumn();
  }
}

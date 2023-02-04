import '../../../../../extensions.dart';
import '../../bloc/settings/user_setting_cubit.dart';
import '../../../../../main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/colors.dart';
import '../../../../../translations/locale_keys.g.dart';

class SettingsScreenChangeGenderSheet extends StatefulWidget {
  const SettingsScreenChangeGenderSheet(this.gender, {Key? key})
      : super(key: key);
  final String gender;
  @override
  State<SettingsScreenChangeGenderSheet> createState() =>
      _SettingsScreenChangeGenderSheetState();
}

class _SettingsScreenChangeGenderSheetState
    extends State<SettingsScreenChangeGenderSheet> {
  late final UserSettingCubit _userSettingCubit;
  late String value;
  @override
  void initState() {
    super.initState();
    _userSettingCubit = BlocProvider.of<UserSettingCubit>(context);
    _userSettingCubit.genderController = TextEditingController();
    value = widget.gender.startsWith('M')
        ? LocaleKeys.male.tr()
        : LocaleKeys.female.tr();
  }

  @override
  void dispose() {
    _userSettingCubit.genderController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return [
      11.toSizedBox,
      SmartSelect<String?>.single(
        choiceStyle: S2ChoiceStyle(
          titleStyle: context.subTitle2.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        modalConfig: S2ModalConfig(
          title: LocaleKeys.your_gender.tr(),
          headerStyle: S2ModalHeaderStyle(
            textStyle: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
        ),
        modalType: S2ModalType.bottomSheet,
        selectedValue: value,
        onChange: (s) {
          setState(() {
            value = s.value!;
            _userSettingCubit.genderController?.text = s.value!;
          });
        },
        tileBuilder: (c, s) => InkWell(
          onTap: s.showModal,
          child: ListTile(
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 14,
            ),
            title: LocaleKeys.your_gender
                .tr()
                .toSubTitle2(fontWeight: FontWeight.w500),
            subtitle: value.toCaption(fontWeight: FontWeight.w500),
          ),
        ),
        choiceItems: [LocaleKeys.male.tr(), LocaleKeys.female.tr()]
            .toList()
            .map(
              (e) => S2Choice(
                value: e,
                title: e,
                style: S2ChoiceStyle(
                  titleStyle:
                      TextStyle(color: isDark ? Colors.white : Colors.black),
                ),
              ),
            )
            .toList(),
      ),
      11.toSizedBox,
      LocaleKeys
          .please_choose_your_gender_this_is_necessary_for_a_more_complete_i
          .tr()
          .toCaption(
              fontWeight: FontWeight.w500,
              color: AppColors.colorPrimary,
              maxLines: 5)
          .toFlexible()
    ].toColumn();
  }
}

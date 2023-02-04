import '../../../../../extensions.dart';
import '../../bloc/settings/user_setting_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/api_constants.dart';
import '../../../../../config/colors.dart';
import '../../../../../core/common/static_data/all_countries.dart';
import '../../../../../main.dart';
import '../../../../../translations/locale_keys.g.dart';

class SettingsScreenChangeLanguage extends StatefulWidget {
  const SettingsScreenChangeLanguage(this.currentLanguage, {Key? key})
      : super(key: key);
  final String currentLanguage;
  @override
  State<SettingsScreenChangeLanguage> createState() =>
      _SettingsScreenChangeLanguageState();
}

class _SettingsScreenChangeLanguageState
    extends State<SettingsScreenChangeLanguage> {
  late String selectedLanguage;

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.currentLanguage;
  }

  @override
  Widget build(BuildContext context) {
    final _settingsCubit = BlocProvider.of<UserSettingCubit>(context);
    return [
      11.toSizedBox,
      SmartSelect<String?>.single(
        modalFilter: true,
        modalFilterBuilder: (ctx, cont) => TextField(
          decoration: InputDecoration(
            hintStyle: context.subTitle1.copyWith(fontWeight: FontWeight.w500),
            hintText: "Search Language",
            border: InputBorder.none,
          ),
        ),
        choiceStyle: S2ChoiceStyle(
          titleStyle: context.subTitle2.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        // title
        modalConfig: S2ModalConfig(
          title: LocaleKeys.language.tr(),
          headerStyle: S2ModalHeaderStyle(
            textStyle: context.subTitle1.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        tileBuilder: (c, s) => ListTile(
          trailing: const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 14,
          ),
          onTap: s.showModal,
          title: LocaleKeys.select_display_language
              .tr()
              .toSubTitle2(fontWeight: FontWeight.w500),
          subtitle: selectedLanguage.toCaption(fontWeight: FontWeight.w500),
        ),
        choiceItems: ApiConstants.allLanguages
            .map(
              (e) => S2Choice(
                value: e,
                title: allLanguagesMap[e],
                style: S2ChoiceStyle(
                  titleStyle: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
            )
            .toList(),
        selectedValue: selectedLanguage,
        onChange: (s) {
          setState(() {
            selectedLanguage = s.value!;
            _settingsCubit.selectedLanguage = s.value;
          });
        },
      ),
      11.toSizedBox,
      ListTile(
        title: LocaleKeys
            .choose_your_preferred_language_for_your_account_interface_this_do
            .tr()
            .toCaption(
              fontWeight: FontWeight.w500,
              color: AppColors.colorPrimary,
              maxLines: 5,
            ),
      ).toFlexible()
    ].toColumn();
  }
}

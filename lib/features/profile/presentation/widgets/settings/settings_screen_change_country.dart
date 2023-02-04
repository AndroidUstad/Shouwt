import '../../../../../core/api_constants.dart';
import '../../../../../core/common/static_data/all_countries.dart';
import '../../../../../extensions.dart';
import '../../bloc/settings/user_setting_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/colors.dart';
import '../../../../../main.dart';
import '../../../../../translations/locale_keys.g.dart';

class SettingsScreenChangeCountry extends StatefulWidget {
  const SettingsScreenChangeCountry(this.currentCountry, {Key? key})
      : super(key: key);
  final String currentCountry;
  @override
  State<SettingsScreenChangeCountry> createState() =>
      _SettingsScreenChangeCountryState();
}

class _SettingsScreenChangeCountryState
    extends State<SettingsScreenChangeCountry> {
  late String country;
  @override
  void initState() {
    super.initState();
    country = widget.currentCountry;
  }

  @override
  Widget build(BuildContext context) {
    final _settingCubit = BlocProvider.of<UserSettingCubit>(context);
    return [
      11.toSizedBox,
      SmartSelect<String?>.single(
        modalFilter: true,
        modalFilterBuilder: (ctx, S2SingleState<String?> cont) => TextField(
          decoration: InputDecoration(
            hintStyle: context.subTitle1.copyWith(fontWeight: FontWeight.w500),
            hintText: "Search Country",
            border: InputBorder.none,
          ),
        ),
        choiceStyle: S2ChoiceStyle(
          titleStyle: context.subTitle2.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        modalConfig: S2ModalConfig(
          title: LocaleKeys.change_country.tr(),
          headerStyle: S2ModalHeaderStyle(
            textStyle: context.subTitle1.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        modalType: S2ModalType.fullPage,
        selectedValue: country,
        onChange: (s) {
          setState(() {
            country = s.value!;
            _settingCubit.selectedCountryId = countryMap[country];
          });
        },
        tileBuilder: (c, s) => ListTile(
          trailing: const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 14,
          ),
          onTap: s.showModal,
          title: 'Country'.toSubTitle2(fontWeight: FontWeight.w500),
          subtitle: country.toCaption(fontWeight: FontWeight.w500),
        ),
        choiceItems: ApiConstants.allCountries
            .toList()
            .map((e) => S2Choice(
                  style: S2ChoiceStyle(
                    titleStyle: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  value: e,
                  title: e,
                ))
            .toList(),
      ),
      11.toSizedBox,
      ListTile(
        title: LocaleKeys
            .choose_the_country_in_which_you_live_this_information_will_be_pub
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

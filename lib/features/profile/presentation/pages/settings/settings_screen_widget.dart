import 'package:auto_route/auto_route.dart';
import '../../../../../extensions.dart';
import '../../bloc/settings/user_setting_cubit.dart';
import 'update_dark_mode_model.dart';
import '../../widgets/settings/settings_screen_change_privacy_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/strings.dart';
import '../../../../../core/routes/routes.gr.dart';
import '../../../../../main.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../data/models/response/get_profile_settings_response/get_profile_settings_response.dart';
import '../../widgets/settings/settings_logout_widget.dart';
import '../../widgets/settings/settings_screen_change_about_sheet.dart';
import '../../widgets/settings/settings_screen_change_country.dart';
import '../../widgets/settings/settings_screen_change_email_sheet.dart';
import '../../widgets/settings/settings_screen_change_gender_sheet.dart';
import '../../widgets/settings/settings_screen_change_language.dart';
import '../../widgets/settings/settings_screen_change_password_sheet.dart';
import '../../widgets/settings/settings_screen_change_username_sheet.dart';
import '../../widgets/settings/settings_screen_change_website_sheet.dart';
import '../../widgets/settings/settings_screen_delete_account_sheet.dart';
import '../../widgets/settings/settings_screen_header_item.dart';
import '../../widgets/settings/settings_screen_setting_item.dart';
import '../../widgets/settings/settings_screen_verify_account.dart';
import '../../widgets/settings/settings_version_number_widget.dart';

class SettingsScreenWidget extends StatelessWidget {
  const SettingsScreenWidget(this.data, {Key? key}) : super(key: key);
  final GetProfileSettingsResponse data;
  @override
  Widget build(BuildContext context) {
    final _userSettingCubit = BlocProvider.of<UserSettingCubit>(context);
    final user = data.data!;
    final gender = user.gender != null
        ? (user.gender == 'M' ? 'Male' : 'Female')
        : 'Your gender';
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.toSizedBox,
            SettingsScreenHeaderItem(
              LocaleKeys.general_profile_settings.tr(),
            ),
            SettingsScreenSettingItem(
              title: LocaleKeys.username.tr(),
              value: user.userName ?? 'Username',
              widget: SettingsScreenChangeUsernameSheet(user),
            ),
            SettingsScreenSettingItem(
              title: LocaleKeys.email_address.tr(),
              value: user.email ?? 'Email',
              widget: SettingsScreenChangeEmailSheet(user),
            ),
            SettingsScreenSettingItem(
              title: LocaleKeys.website_url_address.tr(),
              value: user.website.neann ? user.website! : 'Enter your website',
              widget: SettingsScreenChangeWebsiteSheet(user),
            ),
            SettingsScreenSettingItem(
              title: LocaleKeys.about_you.tr(),
              value: user.aboutYou ?? 'Tell us more about you',
              widget: SettingsScreenChangeAboutSheet(user),
            ),
            SettingsScreenSettingItem(
              title: LocaleKeys.your_gender.tr(),
              value: gender,
              widget: SettingsScreenChangeGenderSheet(gender),
            ),
            20.toSizedBox,
            SettingsScreenHeaderItem(LocaleKeys.user_password.tr()),
            SettingsScreenSettingItem(
              title: LocaleKeys.my_password.tr(),
              value: "* * * * * *",
              widget: SettingsScreenChangePasswordSheet(user),
              saveOnTap: _userSettingCubit.changePassword,
            ),
            20.toSizedBox,
            SettingsScreenHeaderItem(LocaleKeys.language_and_country.tr()),
            SettingsScreenSettingItem(
              title: LocaleKeys.display_language.tr(),
              value: user.language ?? 'languages',
              widget: SettingsScreenChangeLanguage(user.language!),
              saveOnTap: _userSettingCubit.changeLanguage,
            ),
            SettingsScreenSettingItem(
              title: LocaleKeys.the_country_in_which_you_live.tr(),
              value: user.country ?? 'Country',
              widget: SettingsScreenChangeCountry(user.country ?? 'Country'),
            ),
            20.toSizedBox,
            SettingsScreenHeaderItem('Theme'),
            SettingsScreenSettingItem(
              title: isDark ? 'Dark Theme' : 'Light Theme',
              value: 'Click to change theme',
              widget: UpdateDarkModeModel(),
            ),
            20.toSizedBox,
            SettingsScreenHeaderItem(
              LocaleKeys.account_verification.tr(),
            ).toVisibility(true), // should appear if user is not verified
            SettingsScreenSettingItem(
              title: LocaleKeys.verify_my_account.tr(),
              value: LocaleKeys.click_to_submit_a_verification_request.tr(),
              widget: SettingsScreenVerifyAccount(),
              saveOnTap: _userSettingCubit.verifyUser,
            ).toVisibility(true), // should appear if user is not verified
            20.toSizedBox,
            SettingsScreenHeaderItem(
              LocaleKeys.account_privacy_settings.tr(),
            ),
            SettingsScreenSettingItem(
              title: LocaleKeys.account_privacy.tr(),
              value: LocaleKeys.click_to_set_your_account_privacy.tr(),
              widget: SettingsScreenChangePrivacySheet(data.privacySettings!),
            ),

            20.toSizedBox,
            SettingsScreenHeaderItem("Company"),
            SettingsScreenSettingItem(
              title: LocaleKeys.terms_of_use.tr(),
              value: "Click for our terms of usage",
              onTap: () {
                context.router.root.push(
                  WebViewScreenRoute(
                    url: Strings.termsUrl,
                    name: LocaleKeys.terms_of_use.tr(),
                  ),
                );
              },
              widget: Container(),
            ),
            SettingsScreenSettingItem(
              title: LocaleKeys.privacy_policy.tr(),
              value: "Click for our privacy details",
              widget: Container(),
              onTap: () {
                context.router.root.push(
                  WebViewScreenRoute(
                    url: Strings.privacyUrl,
                    name: LocaleKeys.privacy_policy.tr(),
                  ),
                );
              },
            ),
            SettingsScreenSettingItem(
              title: LocaleKeys.cookies.tr(),
              value: "Click for our cookies",
              widget: Container(),
              onTap: () {
                context.router.root.push(
                  WebViewScreenRoute(
                    url: Strings.cookiesPolicy,
                    name: LocaleKeys.cookies.tr(),
                  ),
                );
              },
            ),
            SettingsScreenSettingItem(
              title: LocaleKeys.about_us.tr(),
              value: "Read about us",
              widget: Container(),
              onTap: () {
                context.router.root.push(
                  WebViewScreenRoute(
                    url: Strings.aboutUs,
                    name: LocaleKeys.about_us.tr(),
                  ),
                );
              },
            ),
            20.toSizedBox,
            SettingsScreenHeaderItem(LocaleKeys.delete_profile.tr()),
            SettingsScreenSettingItem(
              title: LocaleKeys.delete.tr(),
              value: LocaleKeys.click_to_confirm_deletion_of_your_profile.tr(),
              widget: SettingsScreenDeleteAccountSheet(),
              saveOnTap: _userSettingCubit.deleteAccount,
              isDelete: true,
            ),
            SettingsLogoutWidget(),
            SettingsVersionNumberWidget(),
          ],
        ),
      ),
    );
  }
}

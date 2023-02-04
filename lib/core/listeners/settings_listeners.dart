import 'package:auto_route/auto_route.dart';
import '../extensions/context_exrensions.dart';
import '../routes/routes.gr.dart';
import '../../features/profile/data/models/response/change_language_response.dart';
import '../../features/profile/data/models/response/delete_account_response.dart';
import '../../features/profile/data/models/response/verify_user_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../features/profile/data/models/response/update_settings_response/update_settings_response.dart';

class SettingsListener {
  static Future<Null> success(dynamic state, BuildContext context) async {
    if (state is UpdateSettingsResponse) {
      context.router.pop().whenComplete(
            () => context.showSnackBar(message: 'Profile updated successfully'),
          );
    } else if (state is ChangeLanguageResponse) {
      context.router.pop().whenComplete(
            () => context.setLocale(
              Locale(state.language),
            ),
          );
    } else if (state is VerifyUserResponse) {
      context.router.pop().whenComplete(
            () =>
                context.showSnackBar(message: 'Verification sent successfully'),
          );
    } else if (state is DeleteAccountResponse) {
      context.router.replaceAll([LoginScreenRoute()]);
    }
  }

  static Null error(String error, BuildContext context) {
    context.showSnackBar(isError: true, message: error);
  }
}

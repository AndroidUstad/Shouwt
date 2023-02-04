import 'package:auto_route/auto_route.dart';
import '../../../../../core/extensions/context_exrensions.dart';
import '../../../../../core/extensions/string_extensions.dart';
import '../../../../../core/extensions/widget_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/datasource/local_data_source.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/routes/routes.gr.dart';
import '../../../../../translations/locale_keys.g.dart';

class SettingsLogoutWidget extends StatelessWidget {
  const SettingsLogoutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: LocaleKeys.logout
          .tr()
          .toCaption(fontWeight: FontWeight.w500, fontSize: 15)
          .toCenter()
          .onTapWidget(
        () {
          context.showAlertDialog(
            widgets: [
              "Yes".toButton().toFlatButton(
                () async {
                  var localDataSource = getIt<LocalDataSource>();
                  await localDataSource.clearData();
                  // Fix the issue
                  context.router.root.pop();
                  context.router.root.pushAndPopUntil(
                    LoginScreenRoute(),
                    predicate: (c) => false,
                  );
                },
              ),
              "No".toButton().toFlatButton(
                () {
                  context.router.root.pop();
                },
              ),
            ],
            title: LocaleKeys
                .are_you_sure_that_you_want_to_log_out_from_your_account
                .tr(),
          );
        },
      ),
    );
  }
}

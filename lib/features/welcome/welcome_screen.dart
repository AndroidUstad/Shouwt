import 'package:auto_route/auto_route.dart';
import 'package:is_first_run/is_first_run.dart';
import '../../../../core/routes/routes.gr.dart';
import '../../../../core/theme/app_icons.dart';
import '../../config/colors.dart';
import '../../config/strings.dart';
import '../../../../extensions.dart';
import 'package:flutter/material.dart';

import '../../core/datasource/local_data_source.dart';
import '../../core/di/injection.dart';
import '../../main.dart';
import '../../restart_widget.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isCalled = false;

  void configureDarkSettings() async {
    if (!isCalled) {
      final isSystemDark = context.isDarkMode();
      bool firstRun = await IsFirstRun.isFirstRun();
      if (isSystemDark != isDark && firstRun) {
        getIt<LocalDataSource>()
            .changeDarkMode(isSystemDark)
            .whenComplete(() => RestartWidget.restartApp(context));
      }
      Future.delayed(Duration(seconds: 1)).then((_) => setState(() {}));
      isCalled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    configureDarkSettings();
    return Material(
      color: isDark ? AppColors.appBlackColor : null,
      child: [
        buildTopView(),
        buildMiddleView(),
        buildBottomView(),
      ].toColumn().toContainer(),
    );
  }

  Widget buildTopView() {
    return [
      Strings.welcome.toHeadLine5(color: AppColors.colorPrimary),
      10.toSizedBox,
      Strings.seeWhats
          .toHeadLine6(
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : AppColors.textColor)
          .toAlign(TextAlign.center)
          .toHorizontalPadding(32),
    ]
        .toColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center)
        .toContainer(alignment: Alignment.bottomCenter)
        .toExpanded();
  }

  Widget buildMiddleView() {
    return [AppIcons.appLogo]
        .toColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center)
        .toContainer(alignment: Alignment.center)
        .toExpanded();
  }

  Widget buildBottomView() {
    return [
      Strings.login
          .toButton(color: Colors.white)
          .toCustomButton(
            () => {
              context.router.root.pushAndPopUntil(
                LoginScreenRoute(),
                predicate: (f) => false,
              )
            },
          )
          .toSymmetricPadding(25, 8),
      Strings.signUp
          .toButton(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500)
          .toFlatButton(() => {
                context.router.root.pushAndPopUntil(
                  SignUpScreenRoute(),
                  predicate: (f) => false,
                )
              })
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.center).toExpanded();
  }
}

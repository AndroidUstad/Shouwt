import 'package:flutter/services.dart';

import 'core/extensions/context_exrensions.dart';
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'config/colors.dart';
import 'main.dart';

class AppThemeData {
  static ThemeData appThemeData(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDark ? AppColors.appBlackColor : Colors.white,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );
    return ThemeData(
      fontFamily: 'Poppins',
      indicatorColor: AppColors.colorPrimary,
      scaffoldBackgroundColor: isDark ? AppColors.appBlackColor : Colors.white,
      appBarTheme: AppBarTheme(
        color: isDark ? AppColors.appBlackColor : Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: isDark ? AppColors.appBlackColor : Colors.white,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        ),
      ),
      textTheme: appTextTheme,
      primaryColor: AppColors.colorPrimary,
      unselectedWidgetColor: AppColors.colorPrimary.withOpacity(.5),
      toggleableActiveColor: AppColors.colorPrimary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: isDark ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDark ? ColorScheme.dark() : ColorScheme.light(),
          ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.colorPrimary,
        selectionColor: AppColors.colorPrimary,
        selectionHandleColor: AppColors.colorPrimary,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.colorPrimary,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.colorPrimary),
          ),
        ),
        unselectedLabelStyle:
            context.subTitle2.copyWith(fontWeight: FontWeight.bold),
        labelStyle: context.subTitle2.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelColor: isDark ? Colors.white : Colors.grey,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark ? AppColors.appBlackColor : Colors.white,
        selectedItemColor: AppColors.colorPrimary,
        unselectedItemColor: isDark ? Colors.white : Colors.grey,
      ),
    );
  }
}

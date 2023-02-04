import 'package:auto_route/auto_route.dart';
import '../../../../../core/extensions/string_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../config/colors.dart';
import '../../../../../core/routes/routes.gr.dart';
import '../../../../../main.dart';
import '../../../../../translations/locale_keys.g.dart';

class SettingsAppBar extends StatelessWidget with PreferredSizeWidget {
  const SettingsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: LocaleKeys.profile_settings.tr().toSubTitle1(
            (url) => context.router.root.push(WebViewScreenRoute(url: url)),
            color: isDark ? Colors.white : AppColors.textColor,
            fontWeight: FontWeight.bold,
            fontFamily1: 'Poppins',
          ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: isDark ? Colors.white : Colors.black,
        ),
        onPressed: context.router.root.pop,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

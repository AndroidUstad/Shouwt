import 'package:auto_route/auto_route.dart';
import '../../../../../extensions.dart';
import '../../bloc/settings/user_setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/colors.dart';
import '../../../../../core/common/buttons/custom_button.dart';
import '../../../../../core/routes/routes.gr.dart';
import '../../../../../main.dart';

class UpdateUserSettingsDialoge extends StatefulWidget {
  const UpdateUserSettingsDialoge({
    Key? key,
    required this.title,
    required this.widget,
    required this.isDelete,
    this.saveOnTap,
  }) : super(key: key);
  final String title;
  final Widget widget;
  final bool isDelete;
  final VoidCallback? saveOnTap;
  @override
  State<UpdateUserSettingsDialoge> createState() =>
      _UpdateUserSettingsDialogeState();
}

class _UpdateUserSettingsDialogeState extends State<UpdateUserSettingsDialoge> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: [
          ListTile(
            leading: const BackButton(),
            title: widget.title
                .toSubTitle1(
                  (url) =>
                      context.router.root.push(WebViewScreenRoute(url: url)),
                  fontWeight: FontWeight.w500,
                )
                .toHorizontalPadding(8),
          ),
          Container(
            color: isDark ? AppColors.appBlackColor : Colors.white,
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                widget.widget,
                20.toSizedBox,
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 50.0),
                  child: CustomButton(
                    text: widget.isDelete ? 'Delete' : 'Save',
                    onTap: widget.saveOnTap ??
                        BlocProvider.of<UserSettingCubit>(context)
                            .updateUserSettings,
                    color: widget.isDelete
                        ? Theme.of(context).errorColor
                        : AppColors.colorPrimary,
                  ),
                )
              ],
            ),
          )
        ].toColumn(mainAxisSize: MainAxisSize.min),
      ),
    );
  }
}

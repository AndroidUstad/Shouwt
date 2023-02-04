import '../../../../../extensions.dart';
import 'update_user_settings_dialoge.dart';
import 'package:flutter/material.dart';

class SettingsScreenSettingItem extends StatelessWidget {
  const SettingsScreenSettingItem({
    Key? key,
    required this.title,
    required this.value,
    required this.widget,
    this.onTap,
    this.saveOnTap,
    this.isDelete = false,
  }) : super(key: key);
  final String title;
  final String value;
  final VoidCallback? onTap;
  final VoidCallback? saveOnTap;
  final Widget widget;
  final bool isDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: .2,
          ),
        ),
      ),
      child: [
        title.toSubTitle2(
          fontWeight: FontWeight.w600,
          align: context.isArabic() ? TextAlign.right : TextAlign.left,
        ),
        5.toSizedBox,
        value.toSubTitle2(
          align: context.isArabic() ? TextAlign.right : TextAlign.left,
        )
      ]
          .toColumn(crossAxisAlignment: CrossAxisAlignment.stretch)
          .toPadding(12)
          .toFlatButton(
        () {
          if (onTap != null)
            onTap!();
          else {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: 10.0.toRoundRectTop,
              builder: (context) => UpdateUserSettingsDialoge(
                title: title,
                widget: widget,
                isDelete: isDelete,
                saveOnTap: saveOnTap,
              ),
            );
          }
        },
      ),
    );
  }
}

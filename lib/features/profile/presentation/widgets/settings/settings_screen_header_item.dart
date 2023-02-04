import '../../../../../core/extensions/context_exrensions.dart';
import '../../../../../core/extensions/string_extensions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreenHeaderItem extends StatelessWidget {
  const SettingsScreenHeaderItem(this.title, {Key? key}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(left: 17.0),
      child: title.toCaption(
        fontWeight: FontWeight.w900,
        fontSize: 19.sp,
        textAlign: context.isArabic() ? TextAlign.right : TextAlign.left,
      ),
    );
  }
}

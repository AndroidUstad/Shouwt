import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/colors.dart';

class PlatformSpecificSwitch extends StatelessWidget {
  const PlatformSpecificSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);
  final bool value;
  final void Function(bool) onChanged;
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.colorPrimary,
          )
        : Switch(value: value, onChanged: onChanged);
  }
}

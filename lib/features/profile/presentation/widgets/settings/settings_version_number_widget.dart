import '../../../../../extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../main.dart';

class SettingsVersionNumberWidget extends StatelessWidget {
  const SettingsVersionNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        [
          "Version $versionNumber".toCaption(fontWeight: FontWeight.w500),
        ]
            .toColumn(
              mainAxisAlignment: MainAxisAlignment.center,
            )
            .toContainer(alignment: Alignment.bottomCenter, height: 100),
        10.toSizedBox,
      ],
    );
  }
}

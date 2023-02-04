import '../../../../../../extensions.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class EmojiSheetWidget extends StatelessWidget {
  const EmojiSheetWidget(this.controller, {Key? key}) : super(key: key);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, keyboardVisible) {
        if (keyboardVisible) FocusManager.instance.primaryFocus?.unfocus();
        return EmojiPicker(
          onEmojiSelected: (_, Emoji selectedEmojiData) => controller
            ..text += selectedEmojiData.emoji
            ..selection = TextSelection.fromPosition(
              TextPosition(
                offset: controller.text.length,
              ),
            ),
          onBackspacePressed: () => controller
            ..text = controller.text.characters.skipLast(1).toString()
            ..selection = TextSelection.fromPosition(
              TextPosition(
                offset: controller.text.length,
              ),
            ),
        ).toContainer(
          height: context.getScreenWidth > 600 ? 400 : 250,
          color: Colors.transparent,
        );
      },
    );
  }
}

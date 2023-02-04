import 'package:flutter/material.dart';

import '../../../../../../config/colors.dart';

class SendReplyElevatedButton extends StatefulWidget {
  const SendReplyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.controller,
    this.text = 'Reply',
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final TextEditingController controller;
  @override
  State<SendReplyElevatedButton> createState() =>
      _SendReplyElevatedButtonState();
}

class _SendReplyElevatedButtonState extends State<SendReplyElevatedButton> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: Text(widget.text),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.colorPrimary,
        disabledForegroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    );
  }
}

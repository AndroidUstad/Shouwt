import 'dart:io';
import 'package:colibri/core/extensions/context_exrensions.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CameraViewConfirmationVideo extends StatefulWidget {
  const CameraViewConfirmationVideo(this.video, {Key? key}) : super(key: key);
  final String video;
  @override
  State<CameraViewConfirmationVideo> createState() =>
      _CameraViewConfirmationVideoState();
}

class _CameraViewConfirmationVideoState
    extends State<CameraViewConfirmationVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(
      File(widget.video),
    )..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: context.getScreenHeight * .75,
        width: double.infinity,
        child: VideoPlayer(_controller),
      ),
    );
  }
}

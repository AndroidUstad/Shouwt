import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../../config/colors.dart';
import '../../../../../../../extensions.dart';
import '../../../../../../core/widgets/circle_painter.dart';

class VideoPlayButton extends StatefulWidget {
  final VideoPlayerController controller;
  const VideoPlayButton(this.controller, {Key? key}) : super(key: key);

  @override
  _VideoPlayButtonState createState() => _VideoPlayButtonState();
}

class _VideoPlayButtonState extends State<VideoPlayButton> {
  bool isIconShown = true;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(betterPlayerEvenetListener);
    widget.controller.setVolume(0.0);
  }

  void betterPlayerEvenetListener() {
    if (widget.controller.value.isPlaying) {
      setState(() {
        isIconShown = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(betterPlayerEvenetListener);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(),
      child: Container(
        height: 30.toHeight as double?,
        width: 30.toHeight as double?,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.colorPrimary,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: const Icon(
            FontAwesomeIcons.play,
            color: Colors.white,
            size: 14,
          ),
        ),
      ),
    ).toVisibility(isIconShown);
  }
}

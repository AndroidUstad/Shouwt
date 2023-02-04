import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTimeLabelWidget extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoTimeLabelWidget(this.controller, {Key? key}) : super(key: key);

  @override
  _VideoTimeLabelWidgetState createState() => _VideoTimeLabelWidgetState();
}

class _VideoTimeLabelWidgetState extends State<VideoTimeLabelWidget> {
  String progress = "00:00:00";
  String duration = "00:00:00";
  String timeLeft = '00:00';
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(betterPlayerEvenetListener);
  }

  void betterPlayerEvenetListener() {
    final _newProgress = widget.controller.value.position.toString();
    final _newDuration = widget.controller.value.duration.toString();
    final format = DateFormat("HH:mm:ss");
    final progressFormat = format.parse(_newProgress);
    final durationFormat = format.parse(_newDuration);
    String difference =
        durationFormat.difference(progressFormat).toString().split('.')[0];
    if (difference[0] == '0') difference = difference.substring(2);
    if (difference[0] == '0') difference = difference.substring(1);
    setState(() {
      timeLeft = difference;
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(betterPlayerEvenetListener);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
      child: Text(
        timeLeft,
        style: TextStyle(
          fontSize: 10,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

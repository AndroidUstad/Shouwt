import '../../../../../../core/extensions/string_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sized_context/sized_context.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FeedVideoItemModalPlayTimer extends StatefulWidget {
  const FeedVideoItemModalPlayTimer(
      {Key? key, this.videoController, this.youtubeController})
      : super(key: key);
  final VideoPlayerController? videoController;
  final YoutubePlayerController? youtubeController;

  @override
  State<FeedVideoItemModalPlayTimer> createState() =>
      _FeedVideoItemModalPlayTimerState();
}

class _FeedVideoItemModalPlayTimerState
    extends State<FeedVideoItemModalPlayTimer> {
  String timePassed = '0:00';
  String videoTime = '0:00';
  late bool isYoutube;
  @override
  @override
  void initState() {
    isYoutube = widget.youtubeController != null;

    if (isYoutube)
      widget.youtubeController!.addListener(_setVideoTimer);
    else
      widget.videoController!.addListener(_setVideoTimer);
    super.initState();
  }

  @override
  void dispose() {
    if (isYoutube)
      widget.youtubeController!.removeListener(_setVideoTimer);
    else
      widget.videoController!.removeListener(_setVideoTimer);
    super.dispose();
  }

  void _setVideoTimer() {
    Duration? duration;
    Duration? position;

    if (isYoutube) {
      duration = widget.youtubeController!.metadata.duration;
      position = widget.youtubeController!.value.position;
    } else {
      duration = widget.videoController!.value.duration;
      position = widget.videoController!.value.position;
    }
    videoTime = _currentVideoTime(duration);
    timePassed = _currentVideoTime(position);

    setState(() {});
  }

  String _currentVideoTime(Duration videoDuration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(videoDuration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(videoDuration.inSeconds.remainder(60));
    String time =
        "${twoDigits(videoDuration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    if (time[1] == '0') time = time.substring(2);
    if (time[0] == ':' && time[1] == '0')
      time = time.substring(2);
    else
      time = time.substring(1);
    return time;
  }

  dynamic get getController =>
      isYoutube ? widget.youtubeController! : widget.videoController!;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.isLandscape
          ? REdgeInsets.only(right: 120.0)
          : EdgeInsets.zero,
      child: ValueListenableBuilder(
        valueListenable: getController,
        builder: (context, _, __) {
          //Do Something with the value.
          return '$timePassed / $videoTime'.toSubTitle2(
            color: Colors.white,
            fontSize: context.isLandscape ? 3.sp : 13.sp,
          );
        },
      ),
    );
  }
}

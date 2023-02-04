import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sized_context/sized_context.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as yt;

class FeedVideoItemSlider extends StatefulWidget {
  const FeedVideoItemSlider(
      {Key? key, this.videoController, this.youtubeController})
      : super(key: key);
  final VideoPlayerController? videoController;
  final yt.YoutubePlayerController? youtubeController;
  @override
  State<FeedVideoItemSlider> createState() => _FeedVideoItemSliderState();
}

class _FeedVideoItemSliderState extends State<FeedVideoItemSlider> {
  Timer? timer;
  late bool isYoutube;

  @override
  void initState() {
    super.initState();
    isYoutube = widget.youtubeController != null;
    timer = Timer.periodic(Duration(microseconds: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          REdgeInsets.symmetric(horizontal: context.isLandscape ? 25.0 : 8.0),
      child: ProgressBar(
        progress: isYoutube
            ? widget.youtubeController!.value.position
            : widget.videoController!.value.position,
        total: isYoutube
            ? widget.youtubeController!.metadata.duration
            : widget.videoController!.value.duration,
        onSeek: (duration) {
          setState(() {
            if (isYoutube)
              widget.youtubeController!.seekTo(duration);
            else
              widget.videoController!.seekTo(duration);
          });
        },
        thumbColor: Colors.white,
        baseBarColor: Colors.grey.withOpacity(0.6),
        progressBarColor: Colors.white.withOpacity(.9),
        timeLabelLocation: TimeLabelLocation.none,
      ),
    );
  }
}

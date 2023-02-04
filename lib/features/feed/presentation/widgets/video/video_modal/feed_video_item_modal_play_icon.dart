import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../core/common/animated_fade_widget.dart';

class FeedVideoItemModalPlayIcon extends StatefulWidget {
  const FeedVideoItemModalPlayIcon(
      {Key? key, this.videoController, this.youtubeController})
      : super(key: key);
  final VideoPlayerController? videoController;
  final YoutubePlayerController? youtubeController;

  @override
  State<FeedVideoItemModalPlayIcon> createState() =>
      _FeedVideoItemModalPlayIconState();
}

class _FeedVideoItemModalPlayIconState
    extends State<FeedVideoItemModalPlayIcon> {
  late bool isYoutube;
  @override
  void initState() {
    super.initState();
    isYoutube = widget.youtubeController != null;
    if (isYoutube) widget.youtubeController!.addListener(_youtubeListener);
  }

  @override
  void dispose() {
    widget.youtubeController?.removeListener(_youtubeListener);
    super.dispose();
  }

  void _youtubeListener() {
    if (widget.youtubeController!.value.isReady) {
      setState(() {});
    }
  }

  void _playPause() {
    if (isYoutube) {
      widget.youtubeController!.value.isPlaying
          ? widget.youtubeController!.pause()
          : widget.youtubeController!.play();
    } else {
      widget.videoController!.value.isPlaying
          ? widget.videoController!.pause()
          : widget.videoController!.play();
    }
    Future.delayed(Duration(milliseconds: 250))
        .whenComplete(() => setState(() {}));
  }

  IconData _isPlayingIcon() {
    if (isYoutube) {
      return widget.youtubeController!.value.isPlaying
          ? Icons.pause_sharp
          : Icons.play_arrow;
    } else {
      return widget.videoController!.value.isPlaying
          ? Icons.pause_sharp
          : Icons.play_arrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeWidget(
      onTap: _playPause,
      child: Icon(_isPlayingIcon(), color: Colors.white),
    );
  }
}

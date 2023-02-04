import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'feed_video_item_modal_play_timer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'feed_video_item_modal_play_icon.dart';
import 'feed_video_item_slider.dart';

class FeedVideoItemPlayRow extends StatefulWidget {
  const FeedVideoItemPlayRow({
    Key? key,
    this.videoController,
    this.youtubeController,
  }) : super(key: key);
  final VideoPlayerController? videoController;
  final YoutubePlayerController? youtubeController;
  @override
  State<FeedVideoItemPlayRow> createState() => _FeedVideoItemPlayRowState();
}

class _FeedVideoItemPlayRowState extends State<FeedVideoItemPlayRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FeedVideoItemModalPlayIcon(
            videoController: widget.videoController,
            youtubeController: widget.youtubeController,
          ),
          Expanded(
              child: FeedVideoItemSlider(
            videoController: widget.videoController,
            youtubeController: widget.youtubeController,
          )),
          FeedVideoItemModalPlayTimer(
            videoController: widget.videoController,
            youtubeController: widget.youtubeController,
          ),
        ],
      ),
    );
  }
}

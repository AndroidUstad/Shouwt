import 'package:colibri/features/feed/presentation/widgets/video/video_modal/feed_video_item_modal_widget.dart';

import '../../../../../core/extensions/string_extensions.dart';
import '../../../../../core/helper_functions.dart';
import '../../../domain/entity/post_entity.dart';
import '../link_fetch/default_circular_progress.dart';
import 'video_modal/video_sound_button.dart';
import 'video_modal/video_time_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class FeedVideoItem extends StatefulWidget {
  const FeedVideoItem(
    this.path, {
    Key? key,
    required this.feedItem,
    required this.thumbnail,
  }) : super(key: key);
  final String? path;
  final PostEntity feedItem;
  final String thumbnail;
  @override
  State<FeedVideoItem> createState() => _FeedVideoItemState();
}

class _FeedVideoItemState extends State<FeedVideoItem> {
  late VideoPlayerController _controller;

  bool isPlaying = false;
  bool? isPortraitVideo;

  @override
  void initState() {
    super.initState();
    playerControllerShow();
    getIsPortrait();
    _controller.setVolume(0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void getIsPortrait() async {
    final imageSize =
        await HelperFunctions.calculateImageDimension(widget.thumbnail);
    isPortraitVideo = imageSize.height > imageSize.width;
    setState(() {});
  }

  // This kicks of then playing video
  void playerControllerShow() {
    bool isNetwork = widget.path!.makeValidUrl.contains("https");
    if (isNetwork)
      _controller = VideoPlayerController.network(widget.path!.makeValidUrl)
        ..initialize().whenComplete(() => setState(() {}));
    else
      _controller = isNetwork
          ? VideoPlayerController.network(widget.path!.makeValidUrl)
          : VideoPlayerController.asset(widget.path!.makeValidUrl)
        ..initialize().whenComplete(() => setState(() {}));

    _controller.play();
    _controller.setLooping(true);
  }

  void _videoLaunchUrl() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, __, ___) {
          return FeedVideoItemModalWidget(
            controller: _controller,
            isPortraitVideo: isPortraitVideo!,
            feedItem: widget.feedItem,
            wasSoundEnabled: _controller.value.volume > 0.0,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isPortraitVideo == null
        ? DefaultCircularProgress()
        : GestureDetector(
            onTap: _videoLaunchUrl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: (isPortraitVideo! ? 350.h : 200.h), // if Landscape
                width: double.infinity,
                color: Colors.black,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      child: _controller.value.isInitialized
                          ? VideoPlayer(_controller)
                          : Container(),
                    ),

                    // time
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: VideoTimeLabelWidget(_controller),
                    ),

                    // sound
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: VideoSoundButton(_controller),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

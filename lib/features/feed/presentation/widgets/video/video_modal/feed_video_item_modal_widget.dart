import 'package:colibri/features/feed/domain/entity/post_entity.dart';
import 'package:colibri/features/feed/presentation/bloc/video_cubit.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../../translations/locale_keys.g.dart';
import '../../../../../posts/domain/entiity/reply_entity.dart';
import '../../../../../posts/presentation/pages/create_post.dart';
import 'feed_item_modal.dart';

class FeedVideoItemModalWidget extends StatefulWidget {
  const FeedVideoItemModalWidget({
    Key? key,
    this.controller,
    this.youtubeController,
    required this.isPortraitVideo,
    required this.feedItem,
    this.wasSoundEnabled,
  }) : super(key: key);
  final VideoPlayerController? controller;
  final YoutubePlayerController? youtubeController;
  final bool isPortraitVideo;
  final PostEntity feedItem;
  final bool? wasSoundEnabled;
  @override
  State<FeedVideoItemModalWidget> createState() =>
      _FeedVideoItemModalWidgetState();
}

class _FeedVideoItemModalWidgetState extends State<FeedVideoItemModalWidget> {
  late bool isYoutube;
  bool isPortraitScreen = false;

  @override
  void initState() {
    super.initState();
    isYoutube = widget.youtubeController != null;
    if (!isYoutube) widget.controller!.setVolume(1.0);
  }

  @override
  void dispose() {
    if (widget.wasSoundEnabled != null) {
      if (!widget.wasSoundEnabled! && !isYoutube)
        widget.controller!.setVolume(0.0);
    }
    super.dispose();
  }

  Widget _videoSizeHandlerWidget({required Widget child}) {
    return isPortraitScreen
        ? AspectRatio(
            aspectRatio: _getContainerWidth() / _getContainerHeight(),
            child: child,
          )
        : Container(
            height: _getContainerHeight(),
            width: _getContainerWidth(),
            child: child,
          );
  }

  double _getContainerHeight() {
    if (isPortraitScreen) return widget.controller!.value.size.height;
    return 1.sh;
  }

  double _getContainerWidth() {
    if (isPortraitScreen) return widget.controller!.value.size.width;
    return widget.isPortraitVideo ? .6.sw : double.infinity;
  }

  @override
  Widget build(BuildContext context) {
    final videoCubit = BlocProvider.of<VideoCubit>(context);
    isPortraitScreen =
        MediaQuery.of(context).orientation == Orientation.portrait;
    if (!isPortraitScreen)
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    isYoutube = widget.youtubeController != null;
    return FeedItemModal(
      feedItem: widget.feedItem,
      controller: widget.controller,
      youtubeController: widget.youtubeController,
      onClickAction: (index) async {
        if (index == 0)
          _openCommentDialoge();
        else if (index == 1)
          videoCubit.likePost(widget.feedItem);
        else if (index == 2)
          videoCubit.repostPost(widget.feedItem);
        else if (index == 3) await Share.share(widget.feedItem.urlForSharing!);
      },
      isVideo: true,
      child: isYoutube
          ? Center(child: YoutubePlayer(controller: widget.youtubeController!))
          : widget.controller!.value.isInitialized
              ? _videoSizeHandlerWidget(child: VideoPlayer(widget.controller!))
              : Container(),
    );
  }

  void _openCommentDialoge() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (c) => DraggableScrollableSheet(
        initialChildSize: 1,
        maxChildSize: 1,
        minChildSize: 1,
        expand: true,
        builder: (BuildContext context, ScrollController scrollController) =>
            Container(
          margin: EdgeInsets.only(
              top: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .padding
                  .top),
          child: CreatePost(
            postEntity: widget.feedItem,
            onClickAction: _openCommentDialoge,
            isCreatePost: false,
            title: LocaleKeys.post_a_reply.tr(),
            replyTo: widget.feedItem.userName,
            threadId: widget.feedItem.postId,
            replyEntity:
                ReplyEntity.fromPostEntity(postEntity: widget.feedItem),
          ),
        ),
      ),
    );
  }
}

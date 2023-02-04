import '../../../features/feed/domain/entity/post_media.dart';
import '../../../features/feed/domain/entity/post_entity.dart';
import '../../../features/feed/presentation/widgets/create_post_card.dart';
import 'package:flutter/material.dart';

import '../../../features/feed/presentation/widgets/video/video_modal/feed_item_modal.dart';
import 'image_slider.dart';

class MediaSlider extends StatefulWidget {
  const MediaSlider({
    Key? key,
    required this.postEntity,
    required this.onClickAction,
    required this.length,
    required this.mediaType,
    required this.mediaUrls,
    required this.pageControllerClick,
  }) : super(key: key);
  final PostEntity? postEntity;
  final Function? onClickAction;
  final int? length;
  final MediaTypeEnum mediaType;
  final List<PostMedia>? mediaUrls;
  final PageController pageControllerClick;
  @override
  State<MediaSlider> createState() => _MediaSliderState();
}

//
class _MediaSliderState extends State<MediaSlider> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FeedItemModal(
        feedItem: widget.postEntity!,
        isVideo: false,
        onClickAction: (index) => widget.onClickAction!(index),
        child: PageView.builder(
          itemCount: widget.length ?? 0,
          controller: widget.pageControllerClick,
          itemBuilder: (context, index) => ImageSlider(
            widget.mediaUrls![index].url!,
          ),
        ),
      ),
    );
  }
}
//
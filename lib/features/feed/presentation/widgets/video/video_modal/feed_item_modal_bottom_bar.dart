import 'dart:async';
import 'package:auto_route/auto_route.dart';
import '../../../../../../core/common/animated_fade_widget.dart';
import '../../../../../../core/routes/routes.gr.dart';
import '../../../bloc/video_cubit.dart';
import '../../all_home_screens.dart';
import '../../create_post_card.dart';
import '../get_media_widget.dart';
import 'send_reply_elevated_button.dart';
import '../../../../../posts/data/model/request/reply_to_post_request.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../../../../extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../../../../../../../config/colors.dart';
import '../../../../../../../../core/theme/app_icons.dart';
import '../../../../../../config/strings.dart';
import '../../../../../../core/common/media/media_data.dart';
import '../../../../../../core/widgets/media_picker.dart';
import '../../../../../posts/presentation/bloc/createpost_cubit.dart';
import '../../../../domain/entity/post_entity.dart';
import '../../../bloc/feed_cubit.dart';
import '../../interaction_row.dart';
import 'emoji_sheet_widget.dart';
import 'feed_video_item_modal_play_row.dart';

//
class FeedItemModalBottomBar extends StatefulWidget {
  const FeedItemModalBottomBar({
    Key? key,
    required this.feedItem,
    this.videoController,
    this.youtubeController,
    required this.isVideo,
    required this.onClickAction,
  }) : super(key: key);
  final PostEntity feedItem;
  final VideoPlayerController? videoController;
  final YoutubePlayerController? youtubeController;
  final bool isVideo;
  final Function(int) onClickAction;
  @override
  State<FeedItemModalBottomBar> createState() => _FeedItemModalBottomBarState();
}

class _FeedItemModalBottomBarState extends State<FeedItemModalBottomBar> {
  final _focus = FocusNode();
  bool _hasFocus = false;
  late final TextEditingController _controller;
  late StreamSubscription<bool> keyboardSubscription;
  late final FeedCubit _feedCubit;

  @override
  void initState() {
    super.initState();
    _feedCubit = BlocProvider.of<FeedCubit>(context);
    _controller = TextEditingController();

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen(_keyboardChangeListener);
  }

  void _keyboardChangeListener(bool val) => setState(() => _hasFocus = val);
  @override
  void dispose() {
    _focus.dispose();
    _controller.dispose();
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoCubit = BlocProvider.of<VideoCubit>(context);
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    final createPostCubit = BlocProvider.of<CreatePostCubit>(context);
    bool isPortraitScreen =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final _emojiSheetOpened = _feedCubit.emojisVisible;
    return Container(
      width: context.getScreenWidth as double,
      padding:
          EdgeInsets.only(bottom: _hasFocus ? bottomInsets : bottomPadding),
      color: _hasFocus ? Colors.black : Colors.transparent,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  if (widget.isVideo)
                    FeedVideoItemPlayRow(
                      videoController: widget.videoController,
                      youtubeController: widget.youtubeController,
                    ),
                  8.toSizedBox,
                  InteractionRow(
                    postEntity: widget.feedItem,
                    onClickAction: (index) => widget.onClickAction(index),
                  ),
                ],
              ).toVisibility(!_hasFocus),
              Padding(
                padding: REdgeInsets.only(top: 8, left: 20),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Replying to ',
                        style: TextStyle(color: AppColors.greyText),
                      ),
                      TextSpan(
                        text: widget.feedItem.name,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.router.push(
                              ProfileScreenRoute(
                                profileUrl: widget.feedItem.userProfileUrl,
                              ),
                            );
                          },
                        style: TextStyle(
                          color: AppColors.colorPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ).toVisibility(_hasFocus && isPortraitScreen),
              Container(
                margin: REdgeInsets.fromLTRB(20, 10, 20, _hasFocus ? 0 : 10),
                padding: _controller.text.isNotEmpty
                    ? REdgeInsets.symmetric(vertical: 8)
                    : EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0.r),
                  ),
                  border: Border.all(color: AppColors.greyText),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    StreamBuilder<List<MediaData>>(
                      stream: createPostCubit.images,
                      initialData: [],
                      builder: (context, snapshot) {
                        return AnimatedSwitcher(
                          key: UniqueKey(),
                          duration: const Duration(milliseconds: 500),
                          child: Wrap(
                              direction: Axis.horizontal,
                              children: List.generate(
                                snapshot.data!.length,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      child: GetMediaWidget(
                                        mediaData: snapshot.data![index],
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                              )).toContainer(),
                        );
                      },
                    ),
                    TextField(
                      style: TextStyle(color: AppColors.white),
                      focusNode: _focus,
                      maxLines: null,
                      onTap: () => _feedCubit.changeEmojisVisiblity(false),
                      controller: _controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: REdgeInsets.all(7),
                        hintText: 'Enter your reply',
                        hintStyle: TextStyle(
                          color: AppColors.greyText,
                          fontWeight: FontWeight.w300,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ).toVisibility(isPortraitScreen),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        AnimatedFadeWidget(
                          onTap: () async {
                            await openMediaPicker(
                              context,
                              createPostCubit.addImage,
                            );
                          },
                          child: AppIcons.imageIcon()
                              .toSizedBox(height: 18, width: 18),
                        ),
                        15.toSizedBoxHorizontal,
                        AnimatedFadeWidget(
                          onTap: () {
                            EmojiSheetWidget(_controller);

                            _feedCubit.changeEmojisVisiblity(true);
                          },
                          child: AppIcons.rowEmojis
                              .toSizedBox(height: 20, width: 20),
                        ),
                        15.toSizedBoxHorizontal,
                        AnimatedFadeWidget(
                          onTap: () async {
                            final gif = await GiphyPicker.pickGif(
                              context: context,
                              apiKey: Strings.giphyApiKey,
                            );
                            if (gif?.images.original?.url != null)
                              createPostCubit.addGif(gif?.images.original?.url);
                          },
                          child: AppIcons.searchIcon(
                            screenType: ScreenType.search(),
                          ).toSizedBox(height: 18, width: 18),
                        ),
                      ],
                    ), //
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 30, maxWidth: 100),
                      child: SendReplyElevatedButton(
                        onPressed: () {
                          String? gif;
                          createPostCubit.mediaItems.forEach((element) {
                            if (element.type == MediaTypeEnum.GIF)
                              gif = element.path;
                          });
                          videoCubit.replyToPost(
                            ReplyToPostRequest(
                              postText: _controller.text,
                              threadId: widget.feedItem.threadID!,
                              gifSrc: gif,
                            ),
                          );
                          _controller.clear();
                          createPostCubit.changeImages([]);
                        },
                        controller: _controller,
                      ),
                    ),
                  ],
                ),
              ).toVisibility(_hasFocus && isPortraitScreen),
            ],
          ),
          if (_emojiSheetOpened) EmojiSheetWidget(_controller),
        ],
      ),
    ).toVisibility(true);
  }

  bool isEmptyTextField() {
    // bool haveMedia = _feedCubit.mediaItems.isEmpty;
    bool haveText = _controller.text.isEmpty;
    return haveText;
  }
}

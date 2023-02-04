import 'package:auto_route/auto_route.dart';
import '../../../../../../core/listeners/video_listeners.dart';
import '../../../bloc/video_cubit.dart';
import 'package:sized_context/sized_context.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../../../../../core/extensions/context_exrensions.dart';
import '../../../../domain/entity/post_entity.dart';
import '../../../bloc/feed_cubit.dart';
import 'feed_item_modal_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../../../config/colors.dart';
import '../../../../../../../../core/common/uistate/common_ui_state.dart';
import '../../../../../../../../core/extensions/color_extension.dart';
import '../../../../../../../../main.dart';

import 'dart:math' as math;

import 'media_close_button.dart';

class FeedItemModal extends StatefulWidget {
  const FeedItemModal({
    Key? key,
    this.controller,
    this.youtubeController,
    required this.feedItem,
    this.wasSoundEnabled,
    required this.onClickAction,
    required this.child,
    required this.isVideo,
  }) : super(key: key);
  final VideoPlayerController? controller;
  final YoutubePlayerController? youtubeController;
  final PostEntity feedItem;
  final bool? wasSoundEnabled;
  final bool isVideo;
  final Function(int) onClickAction;
  final Widget child;
  @override
  State<FeedItemModal> createState() => _FeedItemModalState();
}

//
class _FeedItemModalState extends State<FeedItemModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _bottomModalOffset;
  late Animation<Offset> _closeButtonOffset;
  double _startPosition = 0;
  double _opacity = 1.0;
  late PostEntity currentItem;

  @override
  void initState() {
    super.initState();
    currentItem = widget.feedItem;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    _bottomModalOffset =
        Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
            .animate(_animationController);

    _closeButtonOffset =
        Tween<Offset>(begin: Offset(-0.6, 1.5), end: Offset(-0.6, -2.0))
            .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDark ? AppColors.appBlackColor : Colors.white,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );
    super.dispose();
  }

  void _onPointerDown(PointerDownEvent event) {
    double screenHeight = context.getScreenHeight as double;
    if (_animationController.status == AnimationStatus.dismissed)
      _animationController.forward();
    _startPosition = event.position.dy;
    if (event.position.dy > _startPosition ||
        event.position.dy < _startPosition) {
      var move = (event.position.dy - _startPosition).abs();
      move /= screenHeight;
      _opacity = math.max(1 - move, 0);
    }
    setState(() {});
  }

  void _onPointerUp(PointerUpEvent event) {
    if (_opacity > 0.6) {
      _opacity = 1.0;
      if (_animationController.status == AnimationStatus.completed)
        _animationController.reverse();
      setState(() {});
    }
  }

  void _onPointerMove(PointerMoveEvent event) {
    double screenHeight = context.getScreenHeight as double;

    if (event.position.dy > _startPosition ||
        event.position.dy < _startPosition) {
      var move = (event.position.dy - _startPosition).abs();
      move /= screenHeight;
      _opacity = math.max(1 - move, 0);
      setState(() {});
    }
  }

  void _onImageTap() {
    final _feedCubit = BlocProvider.of<FeedCubit>(context);

    _feedCubit.changeEmojisVisiblity(false);
    switch (_animationController.status) {
      case AnimationStatus.completed:
        _animationController.reverse();
        break;
      case AnimationStatus.dismissed:
        _animationController.forward();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoCubit, CommonUIState>(
      listener: (context, state) => state.maybeWhen(
        orElse: () => null,
        success: (state) => VideoListeners.success(state, context),
        error: (e) => VideoListeners.error(e!, context),
      ),
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => _videoModalWidget(currentItem),
          success: (state) {
            if (state is PostEntity) {
              currentItem = state;
              return _videoModalWidget(currentItem);
            }
            return _videoModalWidget(currentItem);
          },
        );
      },
    );
  }

  Widget _videoModalWidget(PostEntity postEntity) {
    return Container(
      color: HexColor.fromHex('#24282E').withOpacity(_opacity),
      child: BlocBuilder<FeedCubit, CommonUIState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(),
                child: Padding(
                  padding: context.isLandscape
                      ? REdgeInsets.symmetric(horizontal: 60.0)
                      : EdgeInsets.zero,
                  child: GestureDetector(
                    onTap: _onImageTap,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Listener(
                                onPointerDown: _onPointerDown,
                                onPointerUp: _onPointerUp,
                                onPointerMove: _onPointerMove,
                                child: Center(
                                  child: InteractiveViewer(
                                    child: Dismissible(
                                      key: ValueKey(0),
                                      direction: DismissDirection.vertical,
                                      onDismissed: (_) => context.router.pop(),
                                      confirmDismiss: (_) => Future.value(true),
                                      child: widget.child,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0.0,
                          child: SlideTransition(
                            position: _bottomModalOffset,
                            child: FeedItemModalBottomBar(
                              feedItem: postEntity,
                              isVideo: widget.isVideo,
                              videoController: widget.controller,
                              youtubeController: widget.youtubeController,
                              onClickAction: widget.onClickAction,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: SlideTransition(
                            position: _closeButtonOffset,
                            child: MediaCloseButton(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

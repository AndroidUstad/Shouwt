import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:colibri/core/common/animated_fade_widget.dart';
import 'package:colibri/core/extensions/context_exrensions.dart';
import 'package:colibri/features/feed/presentation/widgets/link_fetch/default_circular_progress.dart';
import 'package:colibri/features/stories/presentation/bloc/stories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoViewerScreen extends StatefulWidget {
  const VideoViewerScreen(this.videoPath, {Key? key}) : super(key: key);
  final String videoPath;

  @override
  State<VideoViewerScreen> createState() => _VideoViewerScreenState();
}

// _storiesBloc.uploadSwiftVideo(videoSrc!)
class _VideoViewerScreenState extends State<VideoViewerScreen> {
  late VideoPlayerController _controller;
  late final TextEditingController _captionController;
  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _storiesBloc = BlocProvider.of<StoriesBloc>(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? Container(
                      height: context.getScreenHeight * .65,
                      child: VideoPlayer(_controller),
                    )
                  : DefaultCircularProgress(),
            ),
            Positioned(
              top: 10.h,
              left: 10.w,
              child: AnimatedFadeWidget(
                onTap: context.router.pop,
                child: Icon(Icons.arrow_back),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    REdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        margin: REdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(24.r)),
                        ),
                        child: TextField(
                          controller: _captionController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'Add a caption',
                            contentPadding: REdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 10,
                            ),
                            isDense: true,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24.r)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedFadeWidget(
                      onTap: () => _storiesBloc.uploadSwiftVideo(
                        widget.videoPath,
                        swiftText: _captionController.text,
                      ),
                      child: Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: Center(child: Icon(Icons.check, size: 20)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

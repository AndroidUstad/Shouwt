import 'package:colibri/features/feed/presentation/widgets/link_fetch/default_circular_progress.dart';
import 'package:colibri/features/stories/presentation/bloc/stories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class ViewStoryVideoViewer extends StatefulWidget {
  const ViewStoryVideoViewer(
    this.source, {
    Key? key,
    required this.animationController,
  }) : super(key: key);
  final String source;
  final AnimationController animationController;
  @override
  State<ViewStoryVideoViewer> createState() => _ViewStoryVideoViewerState();
}

class _ViewStoryVideoViewerState extends State<ViewStoryVideoViewer> {
  late final StoriesBloc _storiesBloc;

  @override
  void initState() {
    super.initState();
    _storiesBloc = BlocProvider.of<StoriesBloc>(context);
  }

  @override
  void dispose() {
    _storiesBloc.videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _storiesBloc.videoController = VideoPlayerController.network(widget.source);
    final _storyBloc = BlocProvider.of<StoriesBloc>(context);
    _storyBloc.storyLoading = true;

    return FutureBuilder<void>(
      future: _storiesBloc.videoController!.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          widget.animationController.duration =
              _storiesBloc.videoController!.value.duration;
          _storyBloc.storyLoading = false;
          widget.animationController.forward(from: 0);
          _storiesBloc.videoController!.setVolume(1.0);
          _storiesBloc.videoController!.play();
          return Container(
            height: 400.h,
            child: VideoPlayer(_storiesBloc.videoController!),
          );
        }
        return DefaultCircularProgress();
      },
    );
  }
}

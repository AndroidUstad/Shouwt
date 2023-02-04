import 'package:colibri/features/feed/presentation/widgets/link_fetch/default_circular_progress.dart';
import 'package:colibri/features/stories/presentation/bloc/stories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewStoryImageViewer extends StatefulWidget {
  final String source;
  final AnimationController animationController;
  const ViewStoryImageViewer({
    Key? key,
    required this.source,
    required this.animationController,
  }) : super(key: key);

  @override
  State<ViewStoryImageViewer> createState() => _ViewStoryImageViewerState();
}

class _ViewStoryImageViewerState extends State<ViewStoryImageViewer> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    final _storyBloc = BlocProvider.of<StoriesBloc>(context);
    _storyBloc.storyLoading = true;
    widget.animationController.duration = Duration(seconds: 10);
    Image _image = Image.network(widget.source, fit: BoxFit.fitWidth);
    _image.image
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((_, __) {
      if (mounted) {
        setState(() {
          widget.animationController.forward(from: 0);
          _loading = false;
          _storyBloc.storyLoading = _loading;
        });
      }
    }));
    return _loading
        ? DefaultCircularProgress()
        : Container(
            height: 400.h,
            width: double.infinity,
            child: _image,
          );
  }
}

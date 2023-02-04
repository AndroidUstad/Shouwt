import 'package:colibri/extensions.dart';
import 'package:colibri/features/stories/presentation/bloc/stories_bloc.dart';
import 'package:colibri/features/stories/presentation/widgets/view_story_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewStoryProgressList extends StatelessWidget {
  const ViewStoryProgressList({
    Key? key,
    required this.currentSwift,
    required this.swiftLength,
    required this.animationController,
  }) : super(key: key);
  final int currentSwift;
  final int swiftLength;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    final _storiesBloc = BlocProvider.of<StoriesBloc>(context);
    return Container(
      height: 20.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          double? value;
          if (index > currentSwift) {
            value = 0;
          } else if (index < currentSwift) {
            value = 1;
          }

          return Container(
            width: context.getScreenWidth / swiftLength,
            child: ViewStoryProgressBar(
              duration: _storiesBloc.storyTime.inSeconds,
              backgroundColor: Colors.grey.withOpacity(.3),
              valueColor: Colors.white.withOpacity(.5),
              value: value,
              animationController: animationController,
            ),
          );
        },
        itemCount: swiftLength,
        separatorBuilder: (_, __) => 5.toSizedBoxHorizontal,
      ),
    );
  }
}

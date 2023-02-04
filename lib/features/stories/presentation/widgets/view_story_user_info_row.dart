import 'package:colibri/core/common/animated_fade_widget.dart';
import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/stories/presentation/bloc/stories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:colibri/features/stories/domain/models/response/get_swifts_list_response/datum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/colors.dart';
import '../../../../core/datasource/local_data_source.dart';
import '../../../../core/di/injection.dart';

class ViewStoryUserInfoRow extends StatefulWidget {
  const ViewStoryUserInfoRow(
    this.swift,
    this.index, {
    Key? key,
    required this.animationController,
  }) : super(key: key);
  final Datum swift;
  final int index;
  final AnimationController animationController;

  @override
  State<ViewStoryUserInfoRow> createState() => _ViewStoryUserInfoRowState();
}

class _ViewStoryUserInfoRowState extends State<ViewStoryUserInfoRow> {
  @override
  Widget build(BuildContext context) {
    bool isMe = widget.swift.username! ==
        getIt<LocalDataSource>().getUserData()!.data!.user!.userName;
    final _storiesBloc = BlocProvider.of<StoriesBloc>(context);
    final storyLoading = _storiesBloc.storyLoading;
    final bool isPlaying =
        storyLoading ? true : widget.animationController.isAnimating;
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.swift.avatar!.toRoundNetworkImage(),
              10.toSizedBoxHorizontal,
              widget.swift.username!.toSubTitle2(color: Colors.white),
              Padding(
                padding: REdgeInsets.fromLTRB(3.0, 0, 3.0, 15),
                child: '.'.toCaption(
                  color: AppColors.greyText,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              widget.swift.swift![0].time!.toCaption(
                color: AppColors.greyText,
                fontSize: 14.sp,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                transform: Matrix4.translationValues(0, 2, 0),
                child: AnimatedFadeWidget(
                  onTap: () {
                    if (!_storiesBloc.storyLoading) {
                      if (isPlaying) {
                        widget.animationController.stop();
                        if (_storiesBloc.videoController != null) {
                          _storiesBloc.videoController!.pause();
                        }
                      } else {
                        widget.animationController.forward();
                        if (_storiesBloc.videoController != null) {
                          _storiesBloc.videoController!.play();
                        }
                      }

                      setState(() {});
                    }
                  },
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
              10.toSizedBoxHorizontal,
              if (isMe)
                AnimatedFadeWidget(
                  onTap: () => _storiesBloc
                      .deleteSwift(widget.swift.swift![widget.index].swid!),
                  child: AppIcons.deleteOption(
                    color: Colors.white,
                    height: 25.h,
                    width: 25.w,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

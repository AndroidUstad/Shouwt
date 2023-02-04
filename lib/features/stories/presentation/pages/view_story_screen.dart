import 'package:auto_route/auto_route.dart';
import 'package:colibri/core/common/uistate/common_ui_state.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/stories/domain/models/request/register_swift_view_request.dart';
import 'package:colibri/features/stories/presentation/bloc/stories_bloc.dart';
import 'package:colibri/features/stories/presentation/widgets/view_story_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:colibri/features/stories/domain/models/response/get_swifts_list_response/datum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/listeners/stories_listener.dart';
import '../widgets/view_story_progress_list.dart';
import '../widgets/view_story_user_info_row.dart';
import '../widgets/view_story_video_viewer.dart';

class ViewStoryScreen extends StatefulWidget {
  const ViewStoryScreen(this.swift, {Key? key}) : super(key: key);
  final Datum swift;

  @override
  State<ViewStoryScreen> createState() => _ViewStoryScreenState();
}

class _ViewStoryScreenState extends State<ViewStoryScreen>
    with SingleTickerProviderStateMixin {
  int currentSwift = 0;
  late final StoriesBloc _storiesBloc;
  late final AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _storiesBloc = BlocProvider.of<StoriesBloc>(context);

    _animationController = AnimationController(
      vsync: this,
      duration: _storiesBloc.storyTime,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) _goToNextStory();
    });

    _animationController.forward();

    _viewStory();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoriesBloc, CommonUIState>(
      listener: (_, state) {
        state.maybeWhen(
          orElse: () {},
          loading: () => Center(child: CircularProgressIndicator()),
          success: (state) {
            if (currentSwift >= widget.swift.swift!.length) {
              context.router.pop();
            } else {
              StoriesListener.success(state, context);
            }
          },
          error: (e) => StoriesListener.error(e!, context),
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          orElse: _viewStoryScreenWidget,
          error: (message) => Center(child: message!.toSubTitle2()),
          loading: () => Center(child: CircularProgressIndicator()),
          success: (success) {
            if (currentSwift >= widget.swift.swift!.length) {
              return Scaffold(body: Container());
            }
            return _viewStoryScreenWidget();
          },
        );
      },
    );
  }

  Widget _viewStoryScreenWidget() {
    final source = widget.swift.swift![currentSwift].media!.src!;
    final swiftText = widget.swift.swift![currentSwift].text;
    final topPadding = MediaQuery.of(context).viewPadding.top;
    bool isVideo = source.endsWith('.mp4');
    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.only(top: topPadding),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              color: Colors.black,
              child: Center(
                child: isVideo
                    ? ViewStoryVideoViewer(
                        source,
                        animationController: _animationController,
                      )
                    : ViewStoryImageViewer(
                        source: source,
                        animationController: _animationController,
                      ),
              ),
            ),
            ViewStoryProgressList(
              currentSwift: currentSwift,
              swiftLength: widget.swift.swift!.length,
              animationController: _animationController,
            ),
            Column(
              children: [
                ViewStoryUserInfoRow(
                  widget.swift,
                  currentSwift,
                  animationController: _animationController,
                ),
                Expanded(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _goToPrevStory,
                        child: Container(
                          height: context.getScreenHeight as double,
                          width: context.getScreenWidth / 2,
                          color: Colors.transparent,
                        ),
                      ),
                      GestureDetector(
                        onTap: _goToNextStory,
                        child: Container(
                          height: context.getScreenHeight as double,
                          width: context.getScreenWidth / 2,
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
                if (swiftText != null && swiftText.isNotEmpty)
                  Container(
                    height: 70.h,
                    width: double.infinity,
                    foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(.3),
                          Colors.grey.shade400.withOpacity(.3),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0, 1],
                      ),
                    ),
                    child: Center(
                      child: swiftText.toSubTitle2(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                // Center(child: 'This is Signature'.toCaption())
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _viewStory() {
    _storiesBloc.registerSwiftView(
      RegisterSwiftViewRequest(
        userId: widget.swift.id.toString(),
        swid: widget.swift.swift![currentSwift].swid!,
      ),
    );
  }

  void _goToPrevStory() {
    _animationController.reset();
    if (currentSwift > 0) {
      setState(() {
        currentSwift--;
      });
    } else {
      context.router.pop();
    }
  }

  void _goToNextStory() {
    _animationController.reset();
    if (currentSwift < widget.swift.swift!.length - 1) {
      currentSwift++;
      _viewStory();
      setState(() {});
    } else {
      context.router.pop();
    }
  }
}

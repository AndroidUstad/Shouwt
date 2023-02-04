import 'dart:io';

import 'package:auto_route/auto_route.dart';
import '../../../../core/common/animated_fade_widget.dart';
import '../../../../core/common/uistate/common_ui_state.dart';
import '../../../../core/extensions/context_exrensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../bloc/stories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/color_extension.dart';
import '../../../../core/listeners/stories_listener.dart';
import '../../../../core/theme/images.dart';
import '../../../../core/widgets/media/video_slider.dart';

class StoryImageViewer extends StatelessWidget {
  final bool isVideo;
  final String src;
  const StoryImageViewer({
    Key? key,
    required this.isVideo,
    required this.src,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _storiesBloc = BlocProvider.of<StoriesBloc>(context);
    return BlocListener<StoriesBloc, CommonUIState>(
      listener: (_, state) {
        state.maybeWhen(
          orElse: () {},
          loading: () => Center(child: CircularProgressIndicator()),
          success: (state) => StoriesListener.success(state, context),
          error: (e) => StoriesListener.error(e!, context),
        );
      },
      child: Scaffold(
        body: Container(
          color: HexColor.fromHex('#24282E').withOpacity(1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              closeButton(context),
              Expanded(
                child: isVideo
                    ? VideoSlider(src, Duration.zero)
                    : ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: context.getScreenHeight * .7,
                        ),
                        child: Image.file(File(src), fit: BoxFit.scaleDown),
                      ),
              ),
              AnimatedFadeWidget(
                onTap: () async {
                  final compressedFile = await src.compressImage();

                  context.cropImage(
                    file: compressedFile,
                    onCropped: (path) {
                      if (isVideo)
                        _storiesBloc.uploadSwiftVideo(src);
                      else
                        _storiesBloc.uploadSwiftImage(src);
                    },
                  );
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: REdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.getScreenHeight * .05)
            ],
          ),
        ),
      ),
    );
  }

  Widget closeButton(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: InkWell(
          onTap: context.router.root.pop,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Images.closeButton
                .toSvg(color: Colors.white, height: 40, width: 40),
          ),
        ),
      ),
    );
  }
}

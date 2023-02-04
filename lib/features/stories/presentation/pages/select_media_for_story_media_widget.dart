import 'dart:io';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import '../../../../core/extensions/context_exrensions.dart';
import '../../../../core/routes/routes.gr.dart';
import '../bloc/stories_bloc.dart';
import '../splash_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectMediaForStoryMediaWidget extends StatelessWidget {
  const SelectMediaForStoryMediaWidget({
    Key? key,
    required this.thumbnail,
    required this.videoTime,
    required this.imageSrc,
    required this.videoSrc,
  }) : super(key: key);
  final Uint8List thumbnail;
  final String? videoTime;
  final String? imageSrc;
  final String? videoSrc;
  @override
  Widget build(BuildContext context) {
    bool isVideo = videoTime != null;
    final _storiesBloc = BlocProvider.of<StoriesBloc>(context);
    return Stack(
      children: [
        Image.memory(thumbnail, fit: BoxFit.cover, width: double.infinity),
        if (isVideo)
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                videoTime!,
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
        SplashColorWidget(
          onTap: () async {
            if (isVideo)
              context.router.push(VideoViewerScreenRoute(videoPath: videoSrc!));
            else {
              final editedImage = await context.editImage(File(imageSrc!));
              File imageFile = editedImage.newFile;
              String swiftText = editedImage.caption;
              _storiesBloc.uploadSwiftImage(
                imageFile.path,
                swiftText: swiftText,
              );
            }
          },
        ),
      ],
    );
  }
}

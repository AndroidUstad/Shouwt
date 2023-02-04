import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:colibri/core/common/uistate/common_ui_state.dart';
import 'package:colibri/features/stories/presentation/bloc/stories_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/extensions/duration_extension.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/listeners/stories_listener.dart';
import 'select_media_for_story_media_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../../config/colors.dart';
import '../../../../main.dart';
import '../widgets/create_swift_camera_widget.dart';

class SelectMediaForStoryScreen extends StatefulWidget {
  const SelectMediaForStoryScreen({Key? key}) : super(key: key);

  @override
  State<SelectMediaForStoryScreen> createState() =>
      _SelectMediaForStoryScreenState();
}

class _SelectMediaForStoryScreenState extends State<SelectMediaForStoryScreen> {
  final PagingController<int, AssetEntity> _pagingController =
      PagingController(firstPageKey: 0);

  int size = 0;
  int index = 0;

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchMediaLazily(pageKey);
    });
  }

  Future<void> _fetchMediaLazily(int pageKey) async {
    try {
      int index = 0;
      List<AssetEntity>? _media;

      final List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList();
      if (Platform.isIOS)
        index = albums.indexWhere((element) => element.name == 'Recents');
      if (albums.isEmpty) return null;
      size = await albums[index].assetCountAsync;
      _media = await albums[index].getAssetListPaged(page: pageKey, size: size);

      final isLastPage = _media.length < size;
      if (isLastPage) {
        _pagingController.appendLastPage(_media);
      } else {
        final nextPageKey = pageKey + _media.length;
        _pagingController.appendPage(_media, nextPageKey);
      }
    } catch (error) {
      log('ERROR');

      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          title: 'Select Media'.toSubTitle1(
            (_) {},
            color: isDark ? Colors.white : AppColors.textColor,
            fontWeight: FontWeight.bold,
            fontFamily1: 'Poppins',
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: context.router.root.pop,
          ),
          automaticallyImplyLeading: true,
        ),
        body: PagedGridView<int, AssetEntity>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<AssetEntity>(
            itemBuilder: (context, item, index) {
              return FutureBuilder<MediaClass>(
                future: _mapAssetToMediaClass(item),
                builder: (context, snapshot) {
                  if (index == 0) return CreateSwiftCameraWidget();
                  if (snapshot.data != null && snapshot.hasData) {
                    final media = snapshot.data!;
                    return SelectMediaForStoryMediaWidget(
                      thumbnail: media.thumbnail,
                      videoTime: media.videoTime,
                      imageSrc: media.imageSrc,
                      videoSrc: media.videoPath,
                    );
                  } else
                    return Center(child: CircularProgressIndicator());
                },
              );
            },
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
        ),
      ),
    );
  }

  Future<MediaClass> _mapAssetToMediaClass(AssetEntity asset) async {
    late MediaClass mediaClass;
    Uint8List? file;
    String? videoTime;
    String? imageSrc;
    String? videoPath;
    // get photo or video thumbnail
    file = await asset.thumbnailDataWithSize(ThumbnailSize(200, 200));
    // get video time if asset is video
    if (asset.type == AssetType.video) {
      videoTime = asset.videoDuration.durationToString;
      File? s = await asset.file;
      videoPath = s!.path;
    } else if (asset.type == AssetType.image) {
      final file = await asset.file;
      imageSrc = file!.path;
    }

    mediaClass = MediaClass(
      thumbnail: file!,
      videoTime: videoTime,
      imageSrc: imageSrc,
      videoPath: videoPath,
    );

    return mediaClass;
  }
}

class MediaClass {
  final Uint8List thumbnail;
  final String? videoTime;
  final String? imageSrc;
  final String? videoPath;

  MediaClass({
    required this.thumbnail,
    required this.videoTime,
    required this.imageSrc,
    required this.videoPath,
  });
}

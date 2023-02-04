import '../../../../../core/extensions/context_exrensions.dart';
import '../../../../../core/extensions/widget_extensions.dart';
import '../../../../posts/presentation/bloc/createpost_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/common/media/media_data.dart';
import '../../../../../core/widgets/thumbnail_widget.dart';
import '../create_post_card.dart';

class GetMediaWidget extends StatelessWidget {
  const GetMediaWidget({Key? key, required this.mediaData, required this.index})
      : super(key: key);
  final MediaData mediaData;
  final int index;
  @override
  Widget build(BuildContext context) {
    final createPostCubit = BlocProvider.of<CreatePostCubit>(context);
    switch (mediaData.type) {
      case MediaTypeEnum.IMAGE:
        return ThumbnailWidget(
          data: mediaData,
          onCloseTap: () async {
            await createPostCubit.removedFile(index);
          },
        )
            .onTapWidget(
              () {},
            )
            .toContainer(width: context.getScreenWidth * .45);
      case MediaTypeEnum.VIDEO:
        return Stack(
          children: [
            ThumbnailWidget(
              data: mediaData,
              onCloseTap: () async {
                await createPostCubit.removedFile(index);
              },
            ),
            const Positioned.fill(
                child: const Icon(
              FontAwesomeIcons.play,
              color: Colors.white,
              size: 45,
            )),
          ],
        ).toHorizontalPadding(12).onTapWidget(() {});
      case MediaTypeEnum.GIF:
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GiphyWidget(
            path: mediaData.path,
            fun: () async {
              await createPostCubit.removedFile(index);
            },
          ),
        );
      case MediaTypeEnum.EMOJI:
        return ThumbnailWidget(data: mediaData);
      default:
        return Container();
    }
  }
}

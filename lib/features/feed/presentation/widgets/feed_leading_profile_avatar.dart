import '../../../../extensions.dart';
import '../bloc/feed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/images.dart';
import '../../../profile/domain/entity/profile_entity.dart';

const defaultAvatar = 'https://www.csm-demo.ru/upload/default/avatar-1.png';

class FeedLeadingProfileAvatar extends StatelessWidget {
  const FeedLeadingProfileAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feedCubit = BlocProvider.of<FeedCubit>(context);
    return Padding(
      padding: EdgeInsets.all(5),
      child: StreamBuilder<ProfileEntity>(
        stream: feedCubit.drawerEntity,
        builder: (
          BuildContext context,
          AsyncSnapshot<ProfileEntity> snapshot,
        ) {
          if (snapshot.data == null)
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Images.showFollowing.toSvg(),
            );
          return snapshot.data!.profileUrl!.toRoundNetworkImage(radius: 15);
        },
      ).onTapWidget(() {
        Scaffold.of(context).openDrawer();
      }).toPadding(context.isArabic() ? 10 : 7),
    );
  }
}

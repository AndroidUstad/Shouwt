import '../../data/models/response/like_post_response/like_post_response.dart';
import '../../data/models/response/repost_post_response/repost_post_response.dart';
import '../../domain/entity/post_entity.dart';
import '../../domain/usecase/like_unlike_use_case.dart';
import '../../domain/usecase/reply_to_post_use_case.dart';
import '../../domain/usecase/repost_use_case.dart';
import '../../../posts/data/model/request/reply_to_post_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/uistate/common_ui_state.dart';

class VideoCubit extends Cubit<CommonUIState> {
  final LikeUnlikeUseCase _likeUnlikeUseCase;
  final RepostUseCase _repostUseCase;
  final ReplyToPostUseCase _replyToPostUseCase;
  VideoCubit(
    this._likeUnlikeUseCase,
    this._repostUseCase,
    this._replyToPostUseCase,
  ) : super(const CommonUIState.initial()) {}

  void likePost(PostEntity post) async {
    final response = await _likeUnlikeUseCase(post.postId.toString());
    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (r) {
        final res = LikePostResponse.fromJson(r.data);
        post = post.copyWith(
          likeCount: res.postLikes.toString(),
          isLiked: res.data!.like,
        );
        emit(CommonUIState.success(post));
      },
    );
  }

  void repostPost(PostEntity post) async {
    final response = await _repostUseCase(post.postId.toString());
    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (r) {
        final res = RepostPostResponse.fromJson(r.data);
        post = post.copyWith(
          repostCount: res.postReposts.toString(),
          isReposted: res.data!.repost,
        );
        emit(CommonUIState.success(post));
      },
    );
  }

  void replyToPost(ReplyToPostRequest request) async {
    final response = await _replyToPostUseCase(request);
    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (r) => emit(CommonUIState.success(r)),
    );
  }
}

import '../../../posts/data/model/request/reply_to_post_request.dart';
import '../../../posts/data/model/response/reply_to_post_response/reply_to_post_response.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import '../../../posts/domain/post_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReplyToPostUseCase
    extends UseCase<ReplyToPostResponse, ReplyToPostRequest> {
  final PostRepo? postRepo;

  ReplyToPostUseCase(this.postRepo);
  @override
  Future<Either<Failure, ReplyToPostResponse>> call(ReplyToPostRequest params) {
    return postRepo!.replyToPost(params);
  }
}

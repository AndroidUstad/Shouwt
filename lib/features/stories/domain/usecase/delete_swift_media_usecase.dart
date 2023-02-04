import '../models/response/delete_swift_media_response.dart';
import '../repo/stories_repo.dart';
import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteSwiftMediaUseCase
    extends UseCase<DeleteSwiftMediaResponse, NoParam> {
  final StoriesRepo storiesRepo;
  DeleteSwiftMediaUseCase(this.storiesRepo);

  @override
  Future<Either<Failure, DeleteSwiftMediaResponse>> call(NoParam params) =>
      storiesRepo.deleteSwiftMedia(params);
}

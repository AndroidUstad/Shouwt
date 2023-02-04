import '../models/request/publish_swift_request.dart';
import '../models/response/publish_swift_response.dart';
import '../repo/stories_repo.dart';
import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class PublishSwiftUseCase
    extends UseCase<PublishSwiftResponse, PublishSwiftRequest> {
  final StoriesRepo storiesRepo;
  PublishSwiftUseCase(this.storiesRepo);

  @override
  Future<Either<Failure, PublishSwiftResponse>> call(
          PublishSwiftRequest params) =>
      storiesRepo.publishSwift(params);
}

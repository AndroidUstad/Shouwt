import '../models/request/delete_swift_request.dart';
import '../models/response/delete_swift_response.dart';
import '../repo/stories_repo.dart';
import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteSwiftUseCase
    extends UseCase<DeleteSwiftResponse, DeleteSwiftRequest> {
  final StoriesRepo storiesRepo;
  DeleteSwiftUseCase(this.storiesRepo);

  @override
  Future<Either<Failure, DeleteSwiftResponse>> call(
          DeleteSwiftRequest params) =>
      storiesRepo.deleteSwift(params);
}

import '../models/request/register_swift_view_request.dart';
import '../repo/stories_repo.dart';
import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterSwiftViewUseCase
    extends UseCase<dynamic, RegisterSwiftViewRequest> {
  final StoriesRepo storiesRepo;
  RegisterSwiftViewUseCase(this.storiesRepo);

  @override
  Future<Either<Failure, dynamic>> call(RegisterSwiftViewRequest params) =>
      storiesRepo.registerSwiftView(params);
}

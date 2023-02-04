import '../models/response/get_swifts_list_response/get_swifts_list_response.dart';
import '../repo/stories_repo.dart';
import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSwiftListUseCase extends UseCase<GetSwiftsListResponse, NoParam> {
  final StoriesRepo storiesRepo;
  GetSwiftListUseCase(this.storiesRepo);

  @override
  Future<Either<Failure, GetSwiftsListResponse>> call(NoParam params) =>
      storiesRepo.getSwiftsList(params);
}

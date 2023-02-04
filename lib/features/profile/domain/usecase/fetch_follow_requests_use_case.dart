import '../entity/requests/fetch_follow_requests_model.dart';
import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import '../entity/pagination/fetch_follow_requests_item.dart';
import '../repo/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchFollowRequestsUseCase
    extends UseCase<List<FetchFollowRequestsItem>, FetchFollowRequestsModel> {
  final ProfileRepo? profileRepo;

  FetchFollowRequestsUseCase(this.profileRepo);
  @override
  Future<Either<Failure, List<FetchFollowRequestsItem>>> call(
    FetchFollowRequestsModel params,
  ) =>
      profileRepo!.fetchFollowRequests(params);
}

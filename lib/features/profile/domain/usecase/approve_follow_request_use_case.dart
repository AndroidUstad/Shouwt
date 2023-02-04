import '../entity/requests/approve_follow_request_model.dart';
import '../entity/response/approve_follow_request_response/approve_follow_request_response.dart';
import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import '../repo/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApproveFollowRequestUseCase
    extends UseCase<ApproveFollowRequestResponse, ApproveFollowRequestModel> {
  final ProfileRepo? profileRepo;

  ApproveFollowRequestUseCase(this.profileRepo);
  @override
  Future<Either<Failure, ApproveFollowRequestResponse>> call(
    ApproveFollowRequestModel params,
  ) =>
      profileRepo!.approveFollowRequest(params);
}

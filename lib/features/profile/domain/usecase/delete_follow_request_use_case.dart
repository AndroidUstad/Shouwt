import '../entity/requests/delete_follow_request_model.dart';
import '../entity/response/delete_follow_request_response/delete_follow_request_response.dart';
import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import '../repo/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteFollowRequestUseCase
    extends UseCase<DeleteFollowRequestResponse, DeleteFollowRequestModel> {
  final ProfileRepo? profileRepo;

  DeleteFollowRequestUseCase(this.profileRepo);
  @override
  Future<Either<Failure, DeleteFollowRequestResponse>> call(
    DeleteFollowRequestModel params,
  ) =>
      profileRepo!.deleteFollowRequest(params);
}

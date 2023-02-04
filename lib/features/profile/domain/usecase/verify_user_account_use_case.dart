import '../../data/models/response/verify_user_response.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import '../../data/models/request/verify_request_model.dart';
import '../repo/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyUserAccountUseCase
    extends UseCase<VerifyUserResponse, VerifyUserReqest> {
  final ProfileRepo? profileRepo;

  VerifyUserAccountUseCase(this.profileRepo);
  @override
  Future<Either<Failure, VerifyUserResponse>> call(VerifyUserReqest params) {
    return profileRepo!.verifyUserAccount(params);
  }
}

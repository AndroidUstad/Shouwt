import '../../data/models/response/change_password_response.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import '../../data/models/request/update_password_request.dart';
import '../repo/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase
    extends UseCase<ChangePasswordResponse, ChnagePasswordRequest> {
  final ProfileRepo? profileRepo;
  ChangePasswordUseCase(this.profileRepo);
  @override
  Future<Either<Failure, ChangePasswordResponse>> call(
    ChnagePasswordRequest params,
  ) {
    return profileRepo!.changePassword(params);
  }
}

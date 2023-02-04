import '../entity/requests/update_privacy_settings_request.dart';
import '../entity/response/update_privacy_settings_response.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import '../repo/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdatePrivacyUseCase extends UseCase<UpdatePrivacySettingsResponse,
    UpdatePrivacySettingsRequest> {
  final ProfileRepo? profileRepo;

  UpdatePrivacyUseCase(this.profileRepo);
  @override
  Future<Either<Failure, UpdatePrivacySettingsResponse>> call(
    UpdatePrivacySettingsRequest params,
  ) {
    return profileRepo!.updatePrivacySettings(params);
  }
}

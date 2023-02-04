import '../entity/response/get_privacy_settings_response/get_privacy_settings_response.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import '../repo/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPrivacySettingsUseCase
    extends UseCase<GetPrivacySettingsResponse, NoParam> {
  final ProfileRepo? profileRepo;

  GetPrivacySettingsUseCase(this.profileRepo);
  @override
  Future<Either<Failure, GetPrivacySettingsResponse>> call(NoParam params) {
    return profileRepo!.getPrivacySettings(params);
  }
}

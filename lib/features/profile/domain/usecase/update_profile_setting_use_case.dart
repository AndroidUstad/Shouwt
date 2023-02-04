import '../../data/models/response/update_settings_response/update_settings_response.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import '../../data/models/request/update_setting_request_model.dart';
import '../repo/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProfileSettingsUseCase
    implements UseCase<UpdateSettingsResponse, UpdateSettingsRequestModel> {
  final ProfileRepo? profileRepo;
  UpdateProfileSettingsUseCase(this.profileRepo);

  @override
  Future<Either<Failure, UpdateSettingsResponse>> call(
          UpdateSettingsRequestModel params) =>
      profileRepo!.updateUserSetting(params);
}

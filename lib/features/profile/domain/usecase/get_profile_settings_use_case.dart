import '../../data/models/request/get_profile_settings_request.dart';
import '../../data/models/response/get_profile_settings_response/get_profile_settings_response.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import '../repo/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileSettingsUseCase
    extends UseCase<GetProfileSettingsResponse, GetProfileSettingsRequest> {
  final ProfileRepo? profileRepo;

  GetProfileSettingsUseCase(this.profileRepo);
  @override
  Future<Either<Failure, GetProfileSettingsResponse>> call(
      GetProfileSettingsRequest params) {
    return profileRepo!.getProfileSettings(params);
  }
}

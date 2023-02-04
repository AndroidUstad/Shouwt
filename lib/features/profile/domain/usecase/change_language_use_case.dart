import '../../data/models/request/change_language_request.dart';
import '../../data/models/response/change_language_response.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import '../repo/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangeLanguageUseCase
    extends UseCase<ChangeLanguageResponse, ChangeLanguageRequest> {
  final ProfileRepo? profileRepo;
  ChangeLanguageUseCase(this.profileRepo);
  @override
  Future<Either<Failure, ChangeLanguageResponse>> call(
          ChangeLanguageRequest params) =>
      profileRepo!.changeLanguage(params);
}

import '../models/request/upload_swift_media_request.dart';
import '../models/response/upload_swift_media_response/upload_swift_media_response.dart';
import '../repo/stories_repo.dart';

import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadSwiftMediaUseCaes
    extends UseCase<UploadSwiftMediaResponse, UploadSwiftMediaRequest> {
  final StoriesRepo storiesRepo;
  UploadSwiftMediaUseCaes(this.storiesRepo);

  @override
  Future<Either<Failure, UploadSwiftMediaResponse>> call(
          UploadSwiftMediaRequest params) =>
      storiesRepo.uploadSwiftMedia(params);
}

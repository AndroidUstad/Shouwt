import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import '../models/request/delete_swift_request.dart';
import '../models/request/publish_swift_request.dart';
import '../models/request/register_swift_view_request.dart';
import '../models/request/upload_swift_media_request.dart';
import '../models/response/delete_swift_media_response.dart';
import '../models/response/delete_swift_response.dart';
import '../models/response/get_swifts_list_response/get_swifts_list_response.dart';
import '../models/response/publish_swift_response.dart';
import '../models/response/upload_swift_media_response/upload_swift_media_response.dart';
import 'package:dartz/dartz.dart';

abstract class StoriesRepo {
  Future<Either<Failure, UploadSwiftMediaResponse>> uploadSwiftMedia(
    UploadSwiftMediaRequest params,
  );

  Future<Either<Failure, DeleteSwiftMediaResponse>> deleteSwiftMedia(
    NoParam params,
  );

  Future<Either<Failure, PublishSwiftResponse>> publishSwift(
    PublishSwiftRequest params,
  );

  Future<Either<Failure, DeleteSwiftResponse>> deleteSwift(
    DeleteSwiftRequest params,
  );

  Future<Either<Failure, GetSwiftsListResponse>> getSwiftsList(
    NoParam params,
  );

  Future<Either<Failure, dynamic>> registerSwiftView(
    RegisterSwiftViewRequest params,
  );
}

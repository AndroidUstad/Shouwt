import '../../../core/api_constants.dart';
import '../../../core/common/api/api_helper.dart';
import '../domain/models/response/get_swifts_list_response/get_swifts_list_response.dart';
import '../domain/models/response/upload_swift_media_response/upload_swift_media_response.dart';
import '../domain/models/response/publish_swift_response.dart';
import '../domain/models/response/delete_swift_response.dart';
import '../domain/models/response/delete_swift_media_response.dart';
import '../domain/models/request/upload_swift_media_request.dart';
import '../domain/models/request/register_swift_view_request.dart';
import '../domain/models/request/publish_swift_request.dart';
import '../domain/models/request/delete_swift_request.dart';
import '../../../core/common/usecase.dart';
import '../../../core/common/failure.dart';
import '../domain/repo/stories_repo.dart';
import 'package:dartz/dartz.dart';

class StoriesRepoImplementation implements StoriesRepo {
  final ApiHelper apiHelper;
  StoriesRepoImplementation(this.apiHelper);

  @override
  Future<Either<Failure, DeleteSwiftResponse>> deleteSwift(
    DeleteSwiftRequest params,
  ) async {
    final response =
        await apiHelper.post(ApiConstants.deleteSwift, params.toHashMap());
    return response.fold(
      (l) => Left(l),
      (r) => Right(DeleteSwiftResponse.fromJson(r.data)),
    );
  }

  @override
  Future<Either<Failure, DeleteSwiftMediaResponse>> deleteSwiftMedia(
    NoParam params,
  ) async {
    final response =
        await apiHelper.post(ApiConstants.deleteSwiftMedia, EmptyHashMap());
    return response.fold(
      (l) => Left(l),
      (r) => Right(DeleteSwiftMediaResponse.fromJson(r.data)),
    );
  }

  @override
  Future<Either<Failure, GetSwiftsListResponse>> getSwiftsList(
    NoParam params,
  ) async {
    final response = await apiHelper.get(ApiConstants.getSwiftsList);
    return response.fold(
      (l) => Left(l),
      (r) => Right(GetSwiftsListResponse.fromJson(r.data)),
    );
  }

  @override
  Future<Either<Failure, PublishSwiftResponse>> publishSwift(
    PublishSwiftRequest params,
  ) async {
    final response =
        await apiHelper.post(ApiConstants.publishSwift, params.toMap());
    return response.fold(
      (l) => Left(l),
      (r) => Right(PublishSwiftResponse.fromJson(r.data)),
    );
  }

  @override
  Future<Either<Failure, dynamic>> registerSwiftView(
    RegisterSwiftViewRequest params,
  ) async {
    final response =
        await apiHelper.post(ApiConstants.registerSwiftView, params.toMap());
    return response.fold(
      (l) => Left(l),
      (r) => Right(r.data),
    );
  }

  @override
  Future<Either<Failure, UploadSwiftMediaResponse>> uploadSwiftMedia(
    UploadSwiftMediaRequest params,
  ) async {
    final response =
        await apiHelper.post(ApiConstants.uploadSwiftMedia, params.toMap());
    return response.fold(
      (l) => Left(l),
      (r) => Right(UploadSwiftMediaResponse.fromJson(r.data)),
    );
  }
}

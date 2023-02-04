import 'dart:collection';

import '../../../../core/common/usecase.dart';
import '../models/request/change_language_request.dart';
import '../models/request/delete_account_request.dart';
import '../models/request/get_profile_settings_request.dart';
import '../models/request/update_password_request.dart';
import '../models/response/block_user_response_model.dart';
import '../models/response/change_language_response.dart';
import '../models/response/change_password_response.dart';
import '../models/response/delete_account_response.dart';
import '../models/response/get_profile_settings_response/get_profile_settings_response.dart';
import '../../domain/entity/requests/update_privacy_settings_request.dart';
import '../../domain/entity/response/delete_follow_request_response/delete_follow_request_response.dart';
import '../../domain/entity/response/approve_follow_request_response/approve_follow_request_response.dart';
import '../../domain/entity/requests/fetch_follow_requests_model.dart';
import '../../domain/entity/requests/delete_follow_request_model.dart';
import '../../domain/entity/requests/approve_follow_request_model.dart';
import '../../domain/entity/pagination/fetch_follow_requests_item.dart';
import '../../domain/entity/response/fetch_follow_requests_response/fetch_follow_requests_response.dart';
import '../../domain/entity/response/update_privacy_settings_response.dart';
import '../../domain/entity/response/get_privacy_settings_response/get_privacy_settings_response.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import '../../domain/entity/report_profile_entity.dart';
import '../../../../core/api_constants.dart';
import '../../../../core/common/api/api_helper.dart';
import '../../../../core/common/failure.dart';
import '../../../../core/datasource/local_data_source.dart';
import '../../../feed/domain/entity/post_entity.dart';
import '../../../posts/data/model/response/follwers_response.dart';
import '../models/request/profile_posts_model.dart';
import '../models/request/update_setting_request_model.dart';
import '../models/request/verify_request_model.dart';
import '../models/response/bookmarks_response.dart';
import '../models/response/profile_posts_response.dart';
import '../models/response/profile_response.dart';
import '../../domain/entity/follower_entity.dart';
import '../../domain/entity/profile_entity.dart';
import '../../domain/entity/setting_entity.dart';
import '../../domain/repo/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import '../../../../extensions.dart';
import '../models/response/update_settings_response/update_settings_response.dart';
import '../models/response/verify_user_response.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl extends ProfileRepo {
  final ApiHelper? apiHelper;
  final LocalDataSource? localDataSource;
  final GoogleSignIn? _googleSignIn;
  ProfileRepoImpl(this.apiHelper, this.localDataSource, this._googleSignIn);

  @override
  Future<Either<Failure, ProfileEntity>> getProfileData(
      String? userIdOrUsername) async {
    var loginResponse = await localDataSource!.getUserData();
    var map = {};
    if (userIdOrUsername == null || int.tryParse(userIdOrUsername) != null) {
      map.addAll(
          {"user_id": userIdOrUsername ?? loginResponse!.data!.user!.userId});
    } else {
      map.addAll({"username": userIdOrUsername});
    }

    var either = await apiHelper!
        .get(ApiConstants.profile, queryParameters: HashMap.from(map));
    return either.fold((l) => left(l), (r) {
      final profileResponse = ProfileResponse.fromJson(r.data);
      final profileEntity = ProfileEntity.fromProfileResponse(
        profileResponse: profileResponse,
        loginResponse: loginResponse,
      );
      return right(profileEntity);
    });
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getUserPostByCategory(
    PostCategoryModel model,
  ) async {
    var loginResponse = await localDataSource!.getUserData();
    var map = {
      "user_id": model.userId ?? loginResponse!.data!.user!.userId.toString(),
      "page_size": ApiConstants.pageSize,
      "offset": model.offSetId.toString(),
      "type": _getPostType(model.postCategory),
    };
    var either =
        await apiHelper!.get(ApiConstants.profilePosts, queryParameters: map);
    return either.fold(
      (l) => left(l),
      (r) => right(
        ProfilePostResponse.fromJson(r.data)
            .data!
            .posts!
            .map((e) => PostEntity.fromProfilePosts(e))
            .toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getBookmarks(
      String offsetId) async {
    var map = {
      "page_size": ApiConstants.pageSize,
      "offset": offsetId,
    };
    var either =
        await apiHelper!.get(ApiConstants.getBookmarks, queryParameters: map);
    return either.fold(
        (l) => left(l),
        (r) => right(BookmarksResponse.fromJson(r.data)
            .data!
            .map((e) => PostEntity.fromFeed(e))
            .toList()));
  }

  @override
  Future<Either<Failure, List<FollowerEntity>>> getFollower(
      PostCategoryModel model) async {
    var loginResponse = await localDataSource!.getUserData();
    var map = {
      "user_id": model.userId ?? loginResponse!.data!.user!.userId.toString(),
      "page_size": ApiConstants.pageSize,
      "offset": model.offSetId,
    };
    final either =
        await apiHelper!.get(ApiConstants.fetchFollowers, queryParameters: map);
    return either.fold(
        (l) => left(l),
        (r) => right(FollowersResponse.fromJson(r.data)
            .data!
            .map((e) => FollowerEntity.fromResponse(
                e, loginResponse!.data!.user!.userId == e.id))
            .toList()));
  }

  @override
  Future<Either<Failure, List<FollowerEntity>>> getFollowing(
      PostCategoryModel model) async {
    final loginResponse = await localDataSource!.getUserData();
    final map = {
      "user_id": model.userId ?? loginResponse!.data!.user!.userId.toString(),
      "page_size": ApiConstants.pageSize,
      "offset": model.offSetId,
    };
    var either =
        await apiHelper!.get(ApiConstants.fetchFollowing, queryParameters: map);
    return either.fold(
        (l) => left(l),
        (r) => right(FollowersResponse.fromJson(r.data)
            .data!
            .map((e) => FollowerEntity.fromResponse(
                e, loginResponse!.data!.user!.userId == e.id))
            .toList()));
  }

  // it can accept both user id i.e of int type and username i.e type of string
  @override
  Future<Either<Failure, dynamic>> followUnFollow(String userId) async =>
      await apiHelper!
          .post(ApiConstants.follow, HashMap.from({"user_id": userId}));

  @override
  Future<Either<Failure, SettingEntity>> getUserSettings() async {
    final either = await getProfileData(null);
    return either.fold(
      (l) => left(l),
      (settingResponse) =>
          right(SettingEntity.fromSettingResponse(settingResponse)),
    );
  }

  @override
  Future<Either<Failure, UpdateSettingsResponse>> updateUserSetting(
    UpdateSettingsRequestModel model,
  ) async {
    final either = await apiHelper!.post(
      ApiConstants.updateUserSettings,
      HashMap.from(model.toJson()),
    );
    return either.fold(
        (l) => Left(l), (r) => Right(UpdateSettingsResponse.fromJson(r.data)));
  }

  @override
  Future<Either<Failure, dynamic>> logOutUser() async {
    var post = await apiHelper!.post(ApiConstants.logOut, HashMap());
    return post.fold((l) => left(l), (r) async {
      await localDataSource!.clearData();
      await _googleSignIn!.signOut();
      await FacebookLogin().logOut();
      return right(r);
    });
  }

  @override
  Future<Either<Failure, VerifyUserResponse>> verifyUserAccount(
    VerifyUserReqest params,
  ) async {
    final requestParam = await params.toMap;
    final response =
        await apiHelper!.post(ApiConstants.verifyUser, requestParam);
    return response.fold(
      (l) => Left(l),
      (r) => Right(VerifyUserResponse.fromMap(r.data)),
    );
  }

  @override
  Future<Either<Failure, String?>> updateAvatar(String image) async {
    final either = await apiHelper!.post(ApiConstants.updateAvatar,
        HashMap.from({"avatar": await image.toMultiPart()}));
    return either.fold((l) => left(l), (r) => right(r.data["message"]));
  }

  @override
  Future<Either<Failure, String?>> updateCover(String image) async {
    final either = await apiHelper!.post(ApiConstants.updateCover,
        HashMap.from({"cover": await image.toMultiPart()}));
    return either.fold((l) => left(l), (r) => right(r.data["message"]));
  }

  @override
  Future<Either<Failure, bool>> getLoginMode() async {
    final sl = await localDataSource!.didSocialLoggedIn();
    if (sl != null && sl) {
      return const Right(true);
    } else
      return Left(NoDataFoundFailure(""));
  }

  @override
  Future<Either<Failure, dynamic>> reportProfile(
    ReportProfileEntity profileEntity,
  ) async {
    final either = await apiHelper!
        .post(ApiConstants.reportProfile, HashMap.from(profileEntity.toJson()));
    return either.fold((l) => left(l), (r) => right(r));
  }

  @override
  Future<Either<Failure, BlockUserResponseModel>> blockUser(int userId) async {
    final response = await apiHelper!
        .post(ApiConstants.blockUser, HashMap.from({'user_id': userId}));
    return response.fold(
      (l) => Left(l),
      (r) => Right(BlockUserResponseModel.fromMap(r.data)),
    );
  }

  @override
  Future<Either<Failure, GetProfileSettingsResponse>> getProfileSettings(
    GetProfileSettingsRequest params,
  ) async {
    final response = await apiHelper!.get(
      ApiConstants.profile,
      queryParameters: params.toMap(),
    );
    return response.fold(
      (l) => Left(l),
      (r) => Right(GetProfileSettingsResponse.fromJson(r.data)),
    );
  }

  @override
  Future<Either<Failure, ApproveFollowRequestResponse>> approveFollowRequest(
    ApproveFollowRequestModel params,
  ) async {
    final response = await apiHelper!
        .post(ApiConstants.declineFollowRequest, params.toMap());
    return response.fold(
      (l) => Left(l),
      (r) => Right(ApproveFollowRequestResponse.fromJson(r.data)),
    );
  }

  @override
  Future<Either<Failure, DeleteFollowRequestResponse>> deleteFollowRequest(
    DeleteFollowRequestModel params,
  ) async {
    final response = await apiHelper!
        .post(ApiConstants.declineFollowRequest, params.toMap());
    return response.fold(
      (l) => Left(l),
      (r) => Right(DeleteFollowRequestResponse.fromJson(r.data)),
    );
  }

  @override
  Future<Either<Failure, List<FetchFollowRequestsItem>>> fetchFollowRequests(
    FetchFollowRequestsModel params,
  ) async {
    final response = await apiHelper!.get(
      ApiConstants.fetchFollowRequests,
      queryParameters: params.toMap(),
    );
    return response.fold(
      (l) => Left(l),
      (r) => Right(
        FetchFollowRequestsItem().fromResponse(
          FetchFollowRequestsResponse.fromJson(r.data),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, ChangeLanguageResponse>> changeLanguage(
    ChangeLanguageRequest params,
  ) async {
    final response =
        await apiHelper!.post(ApiConstants.changeLanguage, params.toMap());
    return response.fold(
      (l) => Left(l),
      (r) => Right(
        ChangeLanguageResponse.fromMap(
          r.data,
          params.langeName.getLanguageCode,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, ChangePasswordResponse>> changePassword(
    ChnagePasswordRequest params,
  ) async {
    final response =
        await apiHelper!.post(ApiConstants.changePassword, params.toMap());
    return response.fold(
      (l) => Left(l),
      (r) => Right(ChangePasswordResponse.fromMap(r.data)),
    );
  }

  @override
  Future<Either<Failure, DeleteAccountResponse>> deleteAccount(
    DeleteAccountRequest params,
  ) async {
    final response =
        await apiHelper!.post(ApiConstants.deleteAccount, params.toMap());
    return response.fold(
      (l) => Left(l),
      (r) => Right(DeleteAccountResponse.fromMap(r.data)),
    );
  }

  @override
  Future<Either<Failure, GetPrivacySettingsResponse>> getPrivacySettings(
    NoParam params,
  ) async {
    final response = await apiHelper!.get(ApiConstants.privacySettings);
    return response.fold(
      (l) => Left(l),
      (r) => Right(GetPrivacySettingsResponse.fromJson(r.data)),
    );
  }

  @override
  Future<Either<Failure, UpdatePrivacySettingsResponse>> updatePrivacySettings(
    UpdatePrivacySettingsRequest params,
  ) async {
    final response = await apiHelper!.post(
      ApiConstants.updatePrivacySettings,
      params.toMap(),
    );
    return response.fold(
      (l) => Left(l),
      (r) => Right(UpdatePrivacySettingsResponse.fromMap(r.data)),
    );
  }
}

String? _getPostType(PostCategory? type) {
  switch (type) {
    case PostCategory.POSTS:
      return "posts";
    case PostCategory.LIKED:
      return "likes";
    case PostCategory.MEDIA:
      return "media";
    default:
      return null;
  }
}

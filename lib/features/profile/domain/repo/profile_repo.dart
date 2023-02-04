import '../../../../core/common/usecase.dart';
import '../../data/models/request/delete_account_request.dart';
import '../../data/models/request/get_profile_settings_request.dart';
import '../../data/models/response/change_language_response.dart';
import '../../data/models/response/change_password_response.dart';
import '../../data/models/response/get_profile_settings_response/get_profile_settings_response.dart';
import '../../data/models/response/verify_user_response.dart';
import '../entity/pagination/fetch_follow_requests_item.dart';
import '../entity/requests/approve_follow_request_model.dart';
import '../entity/requests/delete_follow_request_model.dart';
import '../entity/requests/fetch_follow_requests_model.dart';
import '../entity/requests/update_privacy_settings_request.dart';
import '../entity/response/approve_follow_request_response/approve_follow_request_response.dart';
import '../entity/response/delete_follow_request_response/delete_follow_request_response.dart';
import '../entity/response/get_privacy_settings_response/get_privacy_settings_response.dart';
import '../entity/response/update_privacy_settings_response.dart';
import '../../data/models/request/change_language_request.dart';
import '../../data/models/response/block_user_response_model.dart';
import '../../data/models/response/delete_account_response.dart';
import '../../data/models/response/update_settings_response/update_settings_response.dart';
import '../entity/report_profile_entity.dart';

import '../../../../core/common/failure.dart';
import '../../../feed/domain/entity/post_entity.dart';
import '../../data/models/request/profile_posts_model.dart';
import '../../data/models/request/update_password_request.dart';
import '../../data/models/request/update_setting_request_model.dart';
import '../../data/models/request/verify_request_model.dart';
import '../entity/follower_entity.dart';
import '../entity/profile_entity.dart';
import '../entity/setting_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileEntity>> getProfileData(String? userId);
  Future<Either<Failure, GetProfileSettingsResponse>> getProfileSettings(
    GetProfileSettingsRequest params,
  );

  Future<Either<Failure, BlockUserResponseModel>> blockUser(int userId);

  Future<Either<Failure, List<FetchFollowRequestsItem>>> fetchFollowRequests(
    FetchFollowRequestsModel params,
  );
  Future<Either<Failure, ApproveFollowRequestResponse>> approveFollowRequest(
    ApproveFollowRequestModel params,
  );
  Future<Either<Failure, DeleteFollowRequestResponse>> deleteFollowRequest(
    DeleteFollowRequestModel params,
  );
  Future<Either<Failure, GetPrivacySettingsResponse>> getPrivacySettings(
    NoParam params,
  );

  Future<Either<Failure, UpdatePrivacySettingsResponse>> updatePrivacySettings(
    UpdatePrivacySettingsRequest params,
  );

  Future<Either<Failure, List<PostEntity>>> getUserPostByCategory(
      PostCategoryModel model);

  Future<Either<Failure, List<PostEntity>>> getBookmarks(String offsetId);

  Future<Either<Failure, List<FollowerEntity>>> getFollower(
      PostCategoryModel model);

  Future<Either<Failure, List<FollowerEntity>>> getFollowing(
      PostCategoryModel model);

  Future<Either<Failure, dynamic>> followUnFollow(String userId);

  Future<Either<Failure, SettingEntity>> getUserSettings();

  Future<Either<Failure, UpdateSettingsResponse>> updateUserSetting(
    UpdateSettingsRequestModel model,
  );

  Future<Either<Failure, ChangePasswordResponse>> changePassword(
      ChnagePasswordRequest params);

  Future<Either<Failure, dynamic>> logOutUser();

  Future<Either<Failure, DeleteAccountResponse>> deleteAccount(
    DeleteAccountRequest params,
  );

  Future<Either<Failure, VerifyUserResponse>> verifyUserAccount(
    VerifyUserReqest params,
  );

  Future<Either<Failure, ChangeLanguageResponse>> changeLanguage(
    ChangeLanguageRequest params,
  );

  Future<Either<Failure, String?>> updateAvatar(String lang);

  Future<Either<Failure, String?>> updateCover(String lang);

  Future<Either<Failure, bool>> getLoginMode();

  Future<Either<Failure, dynamic>> reportProfile(
      ReportProfileEntity profileEntity);
}

// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: invalid_use_of_protected_member
import 'package:bloc/bloc.dart';
import 'package:colibri/core/common/uistate/common_ui_state.dart';
import 'package:colibri/features/profile/domain/entity/follower_entity.dart';
import 'package:colibri/features/profile/domain/entity/profile_entity.dart';
import 'package:colibri/features/profile/domain/usecase/follow_unfollow_use_case.dart';
import 'package:colibri/features/profile/domain/usecase/get_profile_data_use_case.dart';
import 'package:colibri/features/profile/presentation/pagination/followers/follower_pagination.dart';
import 'package:colibri/features/profile/presentation/pagination/following/following_pagination.dart';
import 'package:colibri/features/profile/presentation/pagination/request/follow_request_pagination.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entity/requests/approve_follow_request_model.dart';
import '../../domain/entity/requests/delete_follow_request_model.dart';
import '../../domain/usecase/approve_follow_request_use_case.dart';
import '../../domain/usecase/delete_follow_request_use_case.dart';

part 'followers_following_state.dart';

@injectable
class FollowersFollowingCubit extends Cubit<CommonUIState> {
  // pagination
  final FollowerPagination followerPagination;
  final FollowingPagination followingPagination;
  final FollowRequestPagination followRequestPagination;

  // use cases
  final FollowUnFollowUseCase? followUnFollowUseCase;
  final GetProfileUseCase? getProfileUseCase;
  final ApproveFollowRequestUseCase _approveFollowRequestUseCase;
  final DeleteFollowRequestUseCase _deleteFollowRequestUseCase;
  // streams
  final _profileEntityController = BehaviorSubject<ProfileEntity>();
  Function(ProfileEntity) get changeProfileEntity =>
      _profileEntityController.sink.add;
  Stream<ProfileEntity> get profileEntity => _profileEntityController.stream;

  FollowersFollowingCubit(
    this.followerPagination,
    this.followingPagination,
    this.followRequestPagination,
    this.followUnFollowUseCase,
    this.getProfileUseCase,
    this._approveFollowRequestUseCase,
    this._deleteFollowRequestUseCase,
  ) : super(const CommonUIState.initial()) {
    followerPagination.changeItemLength(0);
    followingPagination.changeItemLength(0);
  }

  void getProfile(String? userId) async {
    emit(const CommonUIState.loading());
    var either = await getProfileUseCase!(userId!);
    either.fold((l) => emit(CommonUIState.error(l.errorMessage)), (r) {
      changeProfileEntity(r);
      emit(const CommonUIState.success(''));
    });
  }

  void followUnFollow(int index, FollowUnFollowEnums followEnums) async {
    // to use the same follow and unfollow
    // we're using enums to differenciate between follow/unfollow from followers/following page
    FollowerEntity currentItem = followEnums == FollowUnFollowEnums.FOLLOWERS
        ? followerPagination.pagingController.itemList![index]
        : followingPagination.pagingController.itemList![index];
    PagingController<int, FollowerEntity> controller =
        followEnums == FollowUnFollowEnums.FOLLOWERS
            ? followerPagination.pagingController
            : followingPagination.pagingController;

    controller.itemList![index] = currentItem.copyWith(
        isFollowed: !currentItem.isFollowing!,
        buttonText: currentItem.isFollowing! ? "Unfollow" : "follow");
    controller.notifyListeners();

    var either = await followUnFollowUseCase!(currentItem.id.toString());
    either.fold((l) {
      emit(CommonUIState.error(l.errorMessage));
      controller
        ..itemList![index] = currentItem.copyWith(
            isFollowed: !currentItem.isFollowing!,
            buttonText: currentItem.isFollowing! ? "Unfollow" : "follow")
        ..notifyListeners();
    }, (r) {});
  }

  void acceptFollowRequest(int requestId) async {
    emit(const CommonUIState.initial());
    final response = await _approveFollowRequestUseCase(
      ApproveFollowRequestModel(reqId: requestId),
    );
    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (r) {
        followRequestPagination.onRefresh();
        emit(const CommonUIState.success(''));
      },
    );
  }

  void declineFollowRequest(int requestId) async {
    emit(const CommonUIState.initial());
    final response = await _deleteFollowRequestUseCase(
      DeleteFollowRequestModel(reqId: requestId),
    );
    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (r) {
        followRequestPagination.onRefresh();
        emit(const CommonUIState.success(''));
      },
    );
  }

  @override
  Future<void> close() {
    _profileEntityController.close();
    followerPagination.onClose();
    followerPagination.onClose();
    return super.close();
  }
}

enum FollowUnFollowEnums { FOLLOWERS, FOLLOWING }

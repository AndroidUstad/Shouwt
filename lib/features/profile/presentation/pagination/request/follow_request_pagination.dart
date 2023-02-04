import '../../../../../core/api_constants.dart';
import '../../../domain/entity/pagination/fetch_follow_requests_item.dart';
import '../../../domain/entity/requests/fetch_follow_requests_model.dart';
import '../../../domain/usecase/fetch_follow_requests_use_case.dart';
import '../../../../../core/common/failure.dart';
import '../../../../../core/common/pagination/custom_pagination.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class FollowRequestPagination
    extends CustomPagination<FetchFollowRequestsItem> {
  final FetchFollowRequestsUseCase? _fetchFollowRequestsUseCase;
  FollowRequestPagination(this._fetchFollowRequestsUseCase);
  @override
  Future<Either<Failure, List<FetchFollowRequestsItem>>?> getItems(
      int pageKey) async {
    return _fetchFollowRequestsUseCase!(
      FetchFollowRequestsModel(
        offset: pageKey,
        pageSize: ApiConstants.pageSize,
      ),
    );
  }

  @override
  FetchFollowRequestsItem getLastItemWithoutAd(
      List<FetchFollowRequestsItem> item) {
    return item[item.length - 1];
  }

  @override
  int? getNextKey(FetchFollowRequestsItem item) {
    return item.offsetId;
  }

  @override
  bool isLastPage(List<FetchFollowRequestsItem> item) {
    return commonLastPage(item);
  }

  @override
  onClose() {
    super.onClose();
    pagingController.dispose();
  }
}

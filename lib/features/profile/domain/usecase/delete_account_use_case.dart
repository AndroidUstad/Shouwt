import '../../data/models/request/delete_account_request.dart';
import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import '../../data/models/response/delete_account_response.dart';
import '../repo/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAccountUseCase
    extends UseCase<DeleteAccountResponse, DeleteAccountRequest> {
  final ProfileRepo? profileRepo;

  DeleteAccountUseCase(this.profileRepo);
  @override
  Future<Either<Failure, DeleteAccountResponse>> call(
    DeleteAccountRequest params,
  ) =>
      profileRepo!.deleteAccount(params);
}

import 'dart:collection';
import 'dart:io';
import '../../data/models/login_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import '../repo/auth_repo.dart';

@injectable
class LoginWithGoogleUseCase
    extends UseCase<LoginResponse, LoginWithGoogleParams> {
  final AuthRepo? authRepo;
  LoginWithGoogleUseCase(this.authRepo);
  @override
  Future<Either<Failure, LoginResponse>> call(LoginWithGoogleParams params) {
    return authRepo!.googleLogin(params);
  }
}

class LoginWithGoogleParams {
  final String accessToken;

  LoginWithGoogleParams({required this.accessToken});

  HashMap<String, dynamic> toHashMap() {
    return HashMap.from({
      'access_token': accessToken,
      'type': 'google',
      'device_type': Platform.isAndroid ? 'android' : 'ios',
    });
  }
}

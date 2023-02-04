import 'dart:collection';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/common/failure.dart';
import '../../../../core/common/usecase.dart';
import '../../data/models/login_response.dart';
import '../repo/auth_repo.dart';

@injectable
class LoginWithFacebookUseCase
    extends UseCase<LoginResponse, LoginWithFacebookParams> {
  final AuthRepo? authRepo;
  LoginWithFacebookUseCase(this.authRepo);
  @override
  Future<Either<Failure, LoginResponse>> call(LoginWithFacebookParams params) {
    return authRepo!.fbLogin(params);
  }
}

class LoginWithFacebookParams {
  final String accessToken;

  LoginWithFacebookParams({required this.accessToken});

  HashMap<String, dynamic> toHashMap() {
    return HashMap.from({
      'access_token': accessToken,
      'type': 'facebook',
      'device_type': Platform.isAndroid ? 'android' : 'ios',
    });
  }
}

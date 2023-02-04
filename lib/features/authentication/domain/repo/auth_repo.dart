import 'dart:collection';
import '../usecase/login_with_google_use_case.dart';
import '../../../../core/common/failure.dart';
import 'package:dartz/dartz.dart';
import '../../data/models/login_response.dart';
import '../usecase/login_with_facebook_use_case.dart';

abstract class AuthRepo {
  Future<Either<Failure, dynamic>> signIn(HashMap<String, dynamic> hashMap);
  Future<Either<Failure, dynamic>> signUp(HashMap<String, dynamic> hashMap);
  Future<Either<Failure, LoginResponse>> fbLogin(
      LoginWithFacebookParams params);
  Future<Either<Failure, LoginResponse>> googleLogin(
      LoginWithGoogleParams params);
  Future<Either<Failure, String>> resetPassword(String email);
}

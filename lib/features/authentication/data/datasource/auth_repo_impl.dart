import 'dart:collection';
import 'dart:io';
import '../../domain/usecase/login_with_facebook_use_case.dart';
import '../../domain/usecase/login_with_google_use_case.dart';
import '../../../../core/common/api/api_helper.dart';
import '../../../../core/api_constants.dart';
import '../../../../core/common/failure.dart';
import '../../../../core/datasource/local_data_source.dart';
import '../models/login_response.dart';
import '../../domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  final ApiHelper? apiHelper;
  final LocalDataSource? localDataSource;

  AuthRepoImpl(this.apiHelper, this.localDataSource);

  @override
  Future<Either<Failure, dynamic>> signIn(
    HashMap<String, dynamic> hashMap,
  ) async {
    final response = await apiHelper!.post(ApiConstants.loginEndPoint, hashMap);
    return response.fold((l) {
      if (l.errorMessage.toLowerCase().contains("incorrect")) {
        return left(
          ServerFailure(
            "The email and password you entered does not match. Please double-check and try again",
          ),
        );
      }
      return left(l);
    }, (r) async {
      final loginResponse = LoginResponse.fromJson(r.data);
      await localDataSource!.saveUserData(loginResponse);
      final pushToken = await localDataSource!.getPushToken();
      await apiHelper!.post(
          ApiConstants.saveNotificationToken,
          HashMap.from({
            "token": pushToken,
            "type": Platform.isAndroid ? "android" : "ios"
          }));
      return right(r);
    });
  }

  @override
  Future<Either<Failure, dynamic>> signUp(HashMap<String, dynamic> hashMap) {
    return apiHelper!.post(ApiConstants.signUpEndPoint, hashMap);
  }

  @override
  Future<Either<Failure, String>> resetPassword(String email) async {
    HashMap<String, dynamic> map = HashMap()..addAll({"email": email});
    var response = await apiHelper!.post(ApiConstants.resetPassword, map);
    return response.fold((l) => left(l), (r) => right("hello"));
  }

  @override
  Future<Either<Failure, LoginResponse>> fbLogin(
    LoginWithFacebookParams params,
  ) async {
    final response =
        await apiHelper!.post(ApiConstants.socialLogin, params.toHashMap());
    return response.fold(
      (l) => Left(l),
      (r) async {
        final loginResponse = LoginResponse.fromJson(r.data);
        await localDataSource!.saveUserData(loginResponse);
        final pushToken = await localDataSource!.getPushToken();
        await apiHelper!.post(
            ApiConstants.saveNotificationToken,
            HashMap.from({
              "token": pushToken,
              "type": Platform.isAndroid ? "android" : "ios"
            }));
        return Right(loginResponse);
      },
    );
  }

  @override
  Future<Either<Failure, LoginResponse>> googleLogin(
    LoginWithGoogleParams params,
  ) async {
    final response =
        await apiHelper!.post(ApiConstants.socialLogin, params.toHashMap());
    return response.fold(
      (l) => Left(l),
      (r) async {
        final loginResponse = LoginResponse.fromJson(r.data);
        await localDataSource!.saveUserData(loginResponse);
        final pushToken = await localDataSource!.getPushToken();
        await apiHelper!.post(
            ApiConstants.saveNotificationToken,
            HashMap.from({
              "token": pushToken,
              "type": Platform.isAndroid ? "android" : "ios"
            }));
        return Right(loginResponse);
      },
    );
  }
}

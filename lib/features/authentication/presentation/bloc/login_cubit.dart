import 'dart:collection';

import 'package:bloc/bloc.dart';
import '../../domain/usecase/login_with_facebook_use_case.dart';
import '../../domain/usecase/login_with_google_use_case.dart';
import 'login_cubit_helper.dart';
import 'package:dartz/dartz.dart';
import 'sign_up_cubit.dart';
import '../../../../core/common/stream_validators.dart';
import '../../../../core/common/uistate/common_ui_state.dart';
import '../../../../core/common/validators.dart';
import '../../../../core/datasource/local_data_source.dart';
import '../../domain/usecase/login_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<CommonUIState> {
  FieldValidators passwordValidator =
      FieldValidators(null, null, obsecureTextBool: true);
  late FieldValidators emailValidators;
  Stream<bool> get validForm => Rx.combineLatest2<String?, String?, bool>(
          emailValidators.stream, passwordValidator.stream, (a, b) {
        return a != null && b != null && a.isNotEmpty && b.isNotEmpty;
      }).asBroadcastStream();

  final errorTextStream = BoolStreamValidator();

  // use cases
  final LocalDataSource? localDataSource;
  final LoginUseCase? loginUseCase;
  final LoginCubitHelper loginCubitHelper;
  final LoginWithFacebookUseCase loginWithFacebookUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;

  // UI STATE
  bool isPasswordVisible = false;
  // constructor
  LoginCubit(
    this.localDataSource,
    this.loginUseCase,
    this.loginCubitHelper,
    this.loginWithFacebookUseCase,
    this.loginWithGoogleUseCase,
  ) : super(const CommonUIState.initial()) {
    emailValidators =
        FieldValidators(validateEmail, passwordValidator.focusNode);
  }
  void changePasswordVisibility() {
    emit(const CommonUIState.initial());
    isPasswordVisible = !isPasswordVisible;
    emit(const CommonUIState.success(''));
  }

  void loginUser(String email, String password) async {
    // empty case

    emit(const CommonUIState.loading());
    final response = await loginUseCase!(
      HashMap<String, dynamic>.from(
        {"email": email.trim(), "password": password.trim()},
      ),
    );
    response.fold(
      (l) => emit(
        CommonUIState.error(l.errorMessage),
      ),
      (r) => emit(
        CommonUIState.success(SuccessState.LOGIN_SUCCESS),
      ),
    );
  }

  void loginWithFacebook() async {
    emit(const CommonUIState.initial());
    final accessToken = await loginCubitHelper.facebookLogin();
    final response = await loginWithFacebookUseCase(
        LoginWithFacebookParams(accessToken: accessToken));
    return response.fold(
      (l) => Left(l.errorMessage),
      (r) => emit(CommonUIState.success(SuccessState.LOGIN_SUCCESS)),
    );
  }

  void loginWithGoogle() async {
    emit(const CommonUIState.initial());
    final accessToken = await loginCubitHelper.googleLogin();
    final response = await loginWithGoogleUseCase(
      LoginWithGoogleParams(accessToken: accessToken),
    );
    return response.fold(
      (l) => Left(l.errorMessage),
      (r) => emit(CommonUIState.success(SuccessState.LOGIN_SUCCESS)),
    );
  }

  @override
  // ignore: missing_return
  Future<Function> close() {
    emailValidators.onDispose();
    passwordValidator.onDispose();
    errorTextStream.dispose();
    super.close();
    return Future.value(() {});
  }
}

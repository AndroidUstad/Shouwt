import '../../../../../core/common/usecase.dart';
import '../../../../../core/datasource/local_data_source.dart';
import '../../../../../core/extensions/string_extensions.dart';
import '../../../data/models/request/change_language_request.dart';
import '../../../data/models/request/delete_account_request.dart';
import '../../../data/models/request/update_setting_request_model.dart';
import '../../../data/models/request/verify_request_model.dart';
import '../../../domain/usecase/delete_account_use_case.dart';
import '../../../domain/usecase/get_privacy_settings_use_case.dart';
import '../../../domain/usecase/get_profile_settings_use_case.dart';
import '../../../domain/usecase/udpate_password_use_case.dart';
import '../../../domain/usecase/update_privacy_setting_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/uistate/common_ui_state.dart';
import '../../../data/models/request/get_profile_settings_request.dart';
import '../../../data/models/request/update_password_request.dart';
import '../../../domain/usecase/change_language_use_case.dart';
import '../../../domain/usecase/update_profile_setting_use_case.dart';
import '../../../domain/usecase/verify_user_account_use_case.dart';

@injectable
class UserSettingCubit extends Cubit<CommonUIState> {
  //settings

  final GetProfileSettingsUseCase _getProfileSettingsUseCase;
  final UpdateProfileSettingsUseCase _updateProfileSettingsUseCase;
  final LocalDataSource localDataSource;
  final ChangeLanguageUseCase _changeLanguageUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final VerifyUserAccountUseCase _verifyUserAccountUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final GetPrivacySettingsUseCase _getPrivacySettingsUseCase;
  final UpdatePrivacyUseCase _updatePrivacyUseCase;

  UserSettingCubit(
    this._getProfileSettingsUseCase,
    this._updateProfileSettingsUseCase,
    this.localDataSource,
    this._changeLanguageUseCase,
    this._changePasswordUseCase,
    this._verifyUserAccountUseCase,
    this._deleteAccountUseCase,
    this._getPrivacySettingsUseCase,
    this._updatePrivacyUseCase,
  ) : super(const CommonUIState.initial()) {}

  Map<String, dynamic> _profileSettingsMap = {};

  TextEditingController? currentPasswordController;
  TextEditingController? newPasswordController;
  TextEditingController? confirmPasswordController;
  TextEditingController? emailController;
  TextEditingController? websiteController;
  TextEditingController? aboutYouController;
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? usernameController;
  TextEditingController? genderController;
  TextEditingController? verifyFullName;
  TextEditingController? verifyMessage;
  TextEditingController? deleteAccountPassword;
  String? videoMessage;
  String? selectedCountryId;
  String? selectedLanguage;

  void updateUserSettings() async {
    emit(const CommonUIState.initial());
    Map<String, String> data = {
      'first_name': firstNameController?.text ?? '',
      'last_name': lastNameController?.text ?? '',
      'about': aboutYouController?.text ?? '',
      'email': emailController?.text ?? '',
      'username': usernameController?.text ?? '',
      'website': websiteController?.text ?? '',
      'country_id': selectedCountryId ?? '1',
    };
    if (genderController != null && genderController!.text.isNotEmpty) {
      data.addAll({'gender': genderController!.text[0].toUpperCase()});
    }
    data.forEach(
      (key, newValue) => _profileSettingsMap.update(
        key,
        (value) => newValue.isEmpty ? value : newValue,
      ),
    );
    final response = await _updateProfileSettingsUseCase(
      UpdateSettingsRequestModel.fromMap(_profileSettingsMap),
    );
    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (r) {
        emit(CommonUIState.success(r));
        getUserSettings();
      },
    );
  }

  void getUserSettings() async {
    emit(const CommonUIState.initial());
    final data = localDataSource.getUserData()!.data!.user!;
    final response = await _getProfileSettingsUseCase(
      GetProfileSettingsRequest(userId: data.userId!.toString()),
    );

    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (settingsResponse) async {
        _profileSettingsMap = settingsResponse.data!.toJson();
        final privacyResponse = await _getPrivacySettingsUseCase(NoParam());
        privacyResponse.fold(
          (l) => emit(CommonUIState.error(l.errorMessage)),
          (privacyResponse) {
            settingsResponse.privacySettings = privacyResponse;
            emit(CommonUIState.success(settingsResponse));
          },
        );
      },
    );
  }

  void changeLanguage() async {
    emit(const CommonUIState.initial());
    final language = selectedLanguage!.toLowerCase();
    final response = await _changeLanguageUseCase(
      ChangeLanguageRequest(langeName: language),
    );
    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (r) {
        emit(CommonUIState.success(r));
        getUserSettings();
      },
    );
  }

  void changePassword() async {
    emit(const CommonUIState.initial());
    if (confirmPasswordController!.text != newPasswordController!.text) {
      emit(const CommonUIState.error('Password does not match'));
    }
    final response = await _changePasswordUseCase(
      ChnagePasswordRequest(
        newPassword: newPasswordController!.text,
        oldPassword: currentPasswordController!.text,
      ),
    );
    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (r) {
        emit(CommonUIState.success(r));
        getUserSettings();
      },
    );
  }

  void verifyUser() async {
    emit(const CommonUIState.initial());
    final fullName = verifyFullName!.text;
    final message = verifyMessage!.text;
    if (fullName.isEmpty || message.isEmpty || !videoMessage.neann) {
      emit(const CommonUIState.error('Please fill all the forms'));
    }
    final response = await _verifyUserAccountUseCase(
      VerifyUserReqest(
        message: message,
        video: videoMessage!,
        fullName: fullName,
      ),
    );
    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (r) {
        emit(CommonUIState.success(r));
        getUserSettings();
      },
    );
  }

  void deleteAccount() async {
    emit(const CommonUIState.initial());
    if (deleteAccountPassword!.text.isEmpty)
      emit(const CommonUIState.error('Please enter account password'));
    final response = await _deleteAccountUseCase(
      DeleteAccountRequest(password: deleteAccountPassword!.text),
    );
    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (r) => emit(CommonUIState.success(r)),
    );
  }
}

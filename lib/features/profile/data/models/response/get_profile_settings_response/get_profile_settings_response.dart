import '../../../../domain/entity/response/get_privacy_settings_response/get_privacy_settings_response.dart';

import 'data.dart';

class GetProfileSettingsResponse {
  int? code;
  String? message;
  Data? data;
  GetPrivacySettingsResponse? privacySettings;

  GetProfileSettingsResponse({
    this.code,
    this.message,
    this.data,
    this.privacySettings,
  });

  factory GetProfileSettingsResponse.fromJson(Map<String, dynamic> json) {
    return GetProfileSettingsResponse(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'data': data?.toJson(),
      };
}

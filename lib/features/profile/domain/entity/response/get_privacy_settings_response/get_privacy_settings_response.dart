import 'data.dart';

class GetPrivacySettingsResponse {
  int? code;
  String? message;
  Data? data;

  GetPrivacySettingsResponse({this.code, this.message, this.data});

  factory GetPrivacySettingsResponse.fromJson(Map<String, dynamic> json) {
    return GetPrivacySettingsResponse(
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

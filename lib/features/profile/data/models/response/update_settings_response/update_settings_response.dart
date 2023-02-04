import 'data.dart';

class UpdateSettingsResponse {
  int? code;
  String? message;
  Data? data;

  UpdateSettingsResponse({this.code, this.message, this.data});

  factory UpdateSettingsResponse.fromJson(Map<String, dynamic> json) {
    return UpdateSettingsResponse(
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

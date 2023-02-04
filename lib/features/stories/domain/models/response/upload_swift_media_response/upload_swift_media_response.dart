import 'data.dart';

class UploadSwiftMediaResponse {
  int? code;
  String? message;
  Data? data;

  UploadSwiftMediaResponse({this.code, this.message, this.data});

  factory UploadSwiftMediaResponse.fromJson(Map<String, dynamic> json) {
    return UploadSwiftMediaResponse(
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

import 'data.dart';

class ApproveFollowRequestResponse {
  String? message;
  int? code;
  Data? data;

  ApproveFollowRequestResponse({this.message, this.code, this.data});

  factory ApproveFollowRequestResponse.fromJson(Map<String, dynamic> json) {
    return ApproveFollowRequestResponse(
      message: json['message'] as String?,
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        'data': data?.toJson(),
      };
}

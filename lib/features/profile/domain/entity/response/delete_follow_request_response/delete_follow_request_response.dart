import 'data.dart';

class DeleteFollowRequestResponse {
  String? message;
  int? code;
  Data? data;

  DeleteFollowRequestResponse({this.message, this.code, this.data});

  factory DeleteFollowRequestResponse.fromJson(Map<String, dynamic> json) {
    return DeleteFollowRequestResponse(
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

import 'data.dart';

class RepostPostResponse {
  int? postReposts;
  String? message;
  int? code;
  Data? data;

  RepostPostResponse({
    this.postReposts,
    this.message,
    this.code,
    this.data,
  });

  factory RepostPostResponse.fromJson(Map<String, dynamic> json) {
    return RepostPostResponse(
      postReposts: json['post_reposts'] as int?,
      message: json['message'] as String?,
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'post_reposts': postReposts,
        'message': message,
        'code': code,
        'data': data?.toJson(),
      };
}

import 'data.dart';

class ReplyToPostResponse {
  int? postsTotal;
  Data? data;
  int? code;
  String? message;

  ReplyToPostResponse({
    this.postsTotal,
    this.data,
    this.code,
    this.message,
  });

  factory ReplyToPostResponse.fromJson(Map<String, dynamic> json) {
    return ReplyToPostResponse(
      postsTotal: json['posts_total'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'posts_total': postsTotal,
        'data': data?.toJson(),
        'code': code,
        'message': message,
      };
}

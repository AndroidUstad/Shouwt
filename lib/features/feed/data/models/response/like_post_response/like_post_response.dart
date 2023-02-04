import 'data.dart';

class LikePostResponse {
  int? postLikes;
  String? message;
  int? code;
  Data? data;

  LikePostResponse({this.postLikes, this.message, this.code, this.data});

  factory LikePostResponse.fromJson(Map<String, dynamic> json) {
    return LikePostResponse(
      postLikes: json['post_likes'] as int?,
      message: json['message'] as String?,
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'post_likes': postLikes,
        'message': message,
        'code': code,
        'data': data?.toJson(),
      };
}

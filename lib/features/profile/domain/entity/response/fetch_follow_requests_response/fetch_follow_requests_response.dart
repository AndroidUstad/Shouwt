import 'datum.dart';

class FetchFollowRequestsResponse {
  int? code;
  String? message;
  List<Datum>? data;

  FetchFollowRequestsResponse({this.code, this.message, this.data});

  factory FetchFollowRequestsResponse.fromJson(Map<String, dynamic> json) {
    return FetchFollowRequestsResponse(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

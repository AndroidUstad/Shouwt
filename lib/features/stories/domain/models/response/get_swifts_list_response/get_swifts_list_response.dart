import 'datum.dart';

class GetSwiftsListResponse {
  int? code;
  List<Datum>? data;
  String? message;

  GetSwiftsListResponse({this.code, this.data, this.message});

  factory GetSwiftsListResponse.fromJson(Map<String, dynamic> json) {
    return GetSwiftsListResponse(
      code: json['code'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'data': data?.map((e) => e.toJson()).toList(),
        'message': message,
      };
}

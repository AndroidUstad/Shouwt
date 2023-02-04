class DeleteSwiftResponse {
  int? code;
  List<dynamic>? data;
  String? message;

  DeleteSwiftResponse({this.code, this.data, this.message});

  factory DeleteSwiftResponse.fromJson(Map<String, dynamic> json) {
    return DeleteSwiftResponse(
      code: json['code'] as int?,
      data: json['data'] as List<dynamic>?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'data': data,
        'message': message,
      };
}

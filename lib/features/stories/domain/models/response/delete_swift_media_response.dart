class DeleteSwiftMediaResponse {
  int? code;
  List<dynamic>? data;
  String? message;

  DeleteSwiftMediaResponse({this.code, this.data, this.message});

  factory DeleteSwiftMediaResponse.fromJson(Map<String, dynamic> json) {
    return DeleteSwiftMediaResponse(
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

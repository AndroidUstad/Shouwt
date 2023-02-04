class PublishSwiftResponse {
  int? code;
  List<dynamic>? data;
  String? message;

  PublishSwiftResponse({this.code, this.data, this.message});

  factory PublishSwiftResponse.fromJson(Map<String, dynamic> json) {
    return PublishSwiftResponse(
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

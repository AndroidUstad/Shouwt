class ChangePasswordResponse {
  final String message;
  final int code;
  ChangePasswordResponse({required this.message, required this.code});

  factory ChangePasswordResponse.fromMap(Map<String, dynamic> map) {
    return ChangePasswordResponse(
      message: map['message'] as String,
      code: map['code'] as int,
    );
  }
}

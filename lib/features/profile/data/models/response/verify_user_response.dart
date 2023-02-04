// ignore_for_file: public_member_api_docs, sort_constructors_first

class VerifyUserResponse {
  final int code;
  final String message;
  VerifyUserResponse({
    required this.code,
    required this.message,
  });

  factory VerifyUserResponse.fromMap(Map<String, dynamic> map) {
    return VerifyUserResponse(
      code: map['code'] as int,
      message: map['message'] as String,
    );
  }
}

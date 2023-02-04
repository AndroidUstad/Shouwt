class DeleteAccountResponse {
  final int code;
  final String message;
  DeleteAccountResponse({required this.code, required this.message});

  factory DeleteAccountResponse.fromMap(Map<String, dynamic> map) {
    return DeleteAccountResponse(
      code: map['code'] as int,
      message: map['message'] as String,
    );
  }
}

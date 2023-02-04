class UpdatePrivacySettingsResponse {
  final int code;
  final String message;
  UpdatePrivacySettingsResponse({
    required this.code,
    required this.message,
  });

  factory UpdatePrivacySettingsResponse.fromMap(Map<String, dynamic> map) {
    return UpdatePrivacySettingsResponse(
      code: map['code'] as int,
      message: map['message'] as String,
    );
  }
}

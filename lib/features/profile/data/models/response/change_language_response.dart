// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChangeLanguageResponse {
  final String message;
  final int code;
  final String language;
  ChangeLanguageResponse(
      {required this.message, required this.code, required this.language});

  factory ChangeLanguageResponse.fromMap(
    Map<String, dynamic> map,
    String language,
  ) {
    return ChangeLanguageResponse(
      message: map['message'] as String,
      code: map['code'] as int,
      language: language,
    );
  }
}

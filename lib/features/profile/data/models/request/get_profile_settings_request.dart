// ignore_for_file: public_member_api_docs, sort_constructors_first

class GetProfileSettingsRequest {
  final String userId;
  GetProfileSettingsRequest({required this.userId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'user_id': userId};
  }
}

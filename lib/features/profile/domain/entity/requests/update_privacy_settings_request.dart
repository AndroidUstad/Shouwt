// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

class UpdatePrivacySettingsRequest {
  final String profileVisibility;
  final String contactPrivacy;
  final String followPrivacy;
  final String searchVisibility;
  UpdatePrivacySettingsRequest({
    required this.profileVisibility,
    required this.contactPrivacy,
    required this.followPrivacy,
    required this.searchVisibility,
  });

  HashMap<String, dynamic> toMap() {
    return HashMap.from({
      'profile_visibility': profileVisibility,
      'contact_privacy': contactPrivacy,
      'follow_privacy': followPrivacy,
      'search_visibility': searchVisibility,
    });
  }
}

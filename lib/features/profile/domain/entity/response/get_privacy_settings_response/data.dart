class Data {
  String? profileVisibility;
  String? contactPrivacy;
  String? followPrivacy;
  bool? searchVisibility;

  Data({
    this.profileVisibility,
    this.contactPrivacy,
    this.followPrivacy,
    this.searchVisibility,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        profileVisibility: json['profile_visibility'] as String?,
        contactPrivacy: json['contact_privacy'] as String?,
        followPrivacy: json['follow_privacy'] as String?,
        searchVisibility: json['search_visibility'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'profile_visibility': profileVisibility,
        'contact_privacy': contactPrivacy,
        'follow_privacy': followPrivacy,
        'search_visibility': searchVisibility,
      };
}

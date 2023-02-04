class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  bool? isVerified;
  String? website;
  String? aboutYou;
  String? gender;
  String? country;
  int? postCount;
  String? ipAddress;
  int? followingCount;
  int? followerCount;
  String? language;
  String? lastActive;
  String? memberSince;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.isVerified,
    this.website,
    this.aboutYou,
    this.gender,
    this.country,
    this.postCount,
    this.ipAddress,
    this.followingCount,
    this.followerCount,
    this.language,
    this.lastActive,
    this.memberSince,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        userName: json['user_name'] as String?,
        email: json['email'] as String?,
        isVerified: json['is_verified'] as bool?,
        website: json['website'] as String?,
        aboutYou: json['about_you'] as String?,
        gender: json['gender'] as String?,
        country: json['country'] as String?,
        postCount: json['post_count'] as int?,
        ipAddress: json['ip_address'] as String?,
        followingCount: json['following_count'] as int?,
        followerCount: json['follower_count'] as int?,
        language: json['language'] as String?,
        lastActive: json['last_active'] as String?,
        memberSince: json['member_since'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'user_name': userName,
        'email': email,
        'is_verified': isVerified,
        'website': website,
        'about_you': aboutYou,
        'gender': gender,
        'country': country,
        'post_count': postCount,
        'ip_address': ipAddress,
        'following_count': followingCount,
        'follower_count': followerCount,
        'language': language,
        'last_active': lastActive,
        'member_since': memberSince,
      };
}

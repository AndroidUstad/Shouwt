class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? avatar;
  String? cover;
  String? userName;
  String? email;
  bool? isVerified;
  String? website;
  String? aboutYou;
  String? gender;
  String? country;
  int? postCount;
  String? about;
  String? ipAddress;
  int? followingCount;
  int? followerCount;
  String? language;
  String? lastActive;
  String? profilePrivacy;
  String? memberSince;
  bool? isBlockedVisitor;
  bool? isFollowing;
  bool? canViewProfile;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.avatar,
    this.cover,
    this.userName,
    this.email,
    this.isVerified,
    this.website,
    this.aboutYou,
    this.gender,
    this.country,
    this.postCount,
    this.about,
    this.ipAddress,
    this.followingCount,
    this.followerCount,
    this.language,
    this.lastActive,
    this.profilePrivacy,
    this.memberSince,
    this.isBlockedVisitor,
    this.isFollowing,
    this.canViewProfile,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        avatar: json['avatar'] as String?,
        cover: json['cover'] as String?,
        userName: json['user_name'] as String?,
        email: json['email'] as String?,
        isVerified: json['is_verified'] as bool?,
        website: json['website'] as String?,
        aboutYou: json['about_you'] as String?,
        gender: json['gender'] as String?,
        country: json['country'] as String?,
        postCount: json['post_count'] as int?,
        about: json['about'] as String?,
        ipAddress: json['ip_address'] as String?,
        followingCount: json['following_count'] as int?,
        followerCount: json['follower_count'] as int?,
        language: json['language'] as String?,
        lastActive: json['last_active'] as String?,
        profilePrivacy: json['profile_privacy'] as String?,
        memberSince: json['member_since'] as String?,
        isBlockedVisitor: json['is_blocked_visitor'] as bool?,
        isFollowing: json['is_following'] as bool?,
        canViewProfile: json['can_view_profile'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'avatar': avatar,
        'cover': cover,
        'username': userName,
        'email': email,
        'is_verified': isVerified,
        'website': website,
        'about_you': aboutYou,
        'gender': gender,
        'country_id': country,
        'post_count': postCount,
        'about': about,
        'ip_address': ipAddress,
        'following_count': followingCount,
        'follower_count': followerCount,
        'language': language,
        'last_active': lastActive,
        'profile_privacy': profilePrivacy,
        'member_since': memberSince,
        'is_blocked_visitor': isBlockedVisitor,
        'is_following': isFollowing,
        'can_view_profile': canViewProfile,
      };
}

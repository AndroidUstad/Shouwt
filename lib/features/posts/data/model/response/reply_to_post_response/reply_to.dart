class ReplyTo {
  int? id;
  String? url;
  String? avatar;
  String? username;
  String? name;
  String? gender;
  bool? isOwner;
  String? threadUrl;

  ReplyTo({
    this.id,
    this.url,
    this.avatar,
    this.username,
    this.name,
    this.gender,
    this.isOwner,
    this.threadUrl,
  });

  factory ReplyTo.fromJson(Map<String, dynamic> json) => ReplyTo(
        id: json['id'] as int?,
        url: json['url'] as String?,
        avatar: json['avatar'] as String?,
        username: json['username'] as String?,
        name: json['name'] as String?,
        gender: json['gender'] as String?,
        isOwner: json['is_owner'] as bool?,
        threadUrl: json['thread_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'avatar': avatar,
        'username': username,
        'name': name,
        'gender': gender,
        'is_owner': isOwner,
        'thread_url': threadUrl,
      };
}

class Owner {
  int? id;
  String? url;
  String? avatar;
  String? username;
  String? name;
  String? verified;

  Owner({
    this.id,
    this.url,
    this.avatar,
    this.username,
    this.name,
    this.verified,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json['id'] as int?,
        url: json['url'] as String?,
        avatar: json['avatar'] as String?,
        username: json['username'] as String?,
        name: json['name'] as String?,
        verified: json['verified'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'avatar': avatar,
        'username': username,
        'name': name,
        'verified': verified,
      };
}

class Datum {
  int? offsetId;
  int? id;
  String? about;
  int? posts;
  String? avatar;
  String? lastActive;
  String? username;
  String? fname;
  String? lname;
  String? email;
  String? verified;
  String? name;
  String? url;
  bool? pendingReq;

  Datum({
    this.offsetId,
    this.id,
    this.about,
    this.posts,
    this.avatar,
    this.lastActive,
    this.username,
    this.fname,
    this.lname,
    this.email,
    this.verified,
    this.name,
    this.url,
    this.pendingReq,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        offsetId: json['offset_id'] as int?,
        id: json['id'] as int?,
        about: json['about'] as String?,
        posts: json['posts'] as int?,
        avatar: json['avatar'] as String?,
        lastActive: json['last_active'] as String?,
        username: json['username'] as String?,
        fname: json['fname'] as String?,
        lname: json['lname'] as String?,
        email: json['email'] as String?,
        verified: json['verified'] as String?,
        name: json['name'] as String?,
        url: json['url'] as String?,
        pendingReq: json['pending_req'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'offset_id': offsetId,
        'id': id,
        'about': about,
        'posts': posts,
        'avatar': avatar,
        'last_active': lastActive,
        'username': username,
        'fname': fname,
        'lname': lname,
        'email': email,
        'verified': verified,
        'name': name,
        'url': url,
        'pending_req': pendingReq,
      };
}

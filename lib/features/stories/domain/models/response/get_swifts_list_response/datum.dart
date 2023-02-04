import 'swift.dart';

class Datum {
  int? id;
  String? username;
  String? fname;
  String? lname;
  String? avatar;
  List<Swift>? swift;
  String? name;
  String? url;
  bool? isUser;
  bool? hasUnseen;

  Datum({
    this.id,
    this.username,
    this.fname,
    this.lname,
    this.avatar,
    this.swift,
    this.name,
    this.url,
    this.isUser,
    this.hasUnseen,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        username: json['username'] as String?,
        fname: json['fname'] as String?,
        lname: json['lname'] as String?,
        avatar: json['avatar'] as String?,
        swift: (json['swift'] as List<dynamic>?)
            ?.map((e) => Swift.fromJson(e as Map<String, dynamic>))
            .toList(),
        name: json['name'] as String?,
        url: json['url'] as String?,
        isUser: json['is_user'] as bool?,
        hasUnseen: json['has_unseen'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'fname': fname,
        'lname': lname,
        'avatar': avatar,
        'swift': swift?.map((e) => e.toJson()).toList(),
        'name': name,
        'url': url,
        'is_user': isUser,
        'has_unseen': hasUnseen,
      };
}

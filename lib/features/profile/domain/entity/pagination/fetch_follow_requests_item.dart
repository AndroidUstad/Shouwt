import '../response/fetch_follow_requests_response/datum.dart';
import '../response/fetch_follow_requests_response/fetch_follow_requests_response.dart';

class FetchFollowRequestsItem {
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

  FetchFollowRequestsItem({
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

  List<FetchFollowRequestsItem> fromResponse(
      FetchFollowRequestsResponse response) {
    final data = response.data!;
    List<FetchFollowRequestsItem> list = [];
    data.forEach((element) {
      list.add(FetchFollowRequestsItem.fromResponseItem(element));
    });
    return list;
  }

  factory FetchFollowRequestsItem.fromResponseItem(Datum data) {
    return FetchFollowRequestsItem(
      about: data.about,
      avatar: data.avatar,
      email: data.email,
      fname: data.fname,
      id: data.id,
      lastActive: data.lastActive,
      lname: data.lname,
      name: data.name,
      offsetId: data.offsetId,
      pendingReq: data.pendingReq,
      posts: data.posts,
      url: data.url,
      username: data.username,
      verified: data.verified,
    );
  }
  factory FetchFollowRequestsItem.fromJson(Map<String, dynamic> json) {
    return FetchFollowRequestsItem(
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
  }

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

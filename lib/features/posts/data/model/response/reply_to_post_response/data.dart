import 'owner.dart';
import 'reply_to.dart';

class Data {
  int? id;
  int? userId;
  String? text;
  String? type;
  String? replysCount;
  String? repostsCount;
  String? likesCount;
  String? status;
  int? threadId;
  String? target;
  String? ogData;
  String? time;
  bool? advertising;
  String? timeRaw;
  String? ogText;
  String? ogImage;
  String? url;
  bool? canDelete;
  List<dynamic>? media;
  bool? isOwner;
  bool? hasLiked;
  bool? hasSaved;
  bool? hasReposted;
  ReplyTo? replyTo;
  int? offsetId;
  Owner? owner;

  Data({
    this.id,
    this.userId,
    this.text,
    this.type,
    this.replysCount,
    this.repostsCount,
    this.likesCount,
    this.status,
    this.threadId,
    this.target,
    this.ogData,
    this.time,
    this.advertising,
    this.timeRaw,
    this.ogText,
    this.ogImage,
    this.url,
    this.canDelete,
    this.media,
    this.isOwner,
    this.hasLiked,
    this.hasSaved,
    this.hasReposted,
    this.replyTo,
    this.offsetId,
    this.owner,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        text: json['text'] as String?,
        type: json['type'] as String?,
        replysCount: json['replys_count'] as String?,
        repostsCount: json['reposts_count'] as String?,
        likesCount: json['likes_count'] as String?,
        status: json['status'] as String?,
        threadId: json['thread_id'] as int?,
        target: json['target'] as String?,
        ogData: json['og_data'] as String?,
        time: json['time'] as String?,
        advertising: json['advertising'] as bool?,
        timeRaw: json['time_raw'] as String?,
        ogText: json['og_text'] as String?,
        ogImage: json['og_image'] as String?,
        url: json['url'] as String?,
        canDelete: json['can_delete'] as bool?,
        media: json['media'] as List<dynamic>?,
        isOwner: json['is_owner'] as bool?,
        hasLiked: json['has_liked'] as bool?,
        hasSaved: json['has_saved'] as bool?,
        hasReposted: json['has_reposted'] as bool?,
        replyTo: json['reply_to'] == null
            ? null
            : ReplyTo.fromJson(json['reply_to'] as Map<String, dynamic>),
        offsetId: json['offset_id'] as int?,
        owner: json['owner'] == null
            ? null
            : Owner.fromJson(json['owner'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'text': text,
        'type': type,
        'replys_count': replysCount,
        'reposts_count': repostsCount,
        'likes_count': likesCount,
        'status': status,
        'thread_id': threadId,
        'target': target,
        'og_data': ogData,
        'time': time,
        'advertising': advertising,
        'time_raw': timeRaw,
        'og_text': ogText,
        'og_image': ogImage,
        'url': url,
        'can_delete': canDelete,
        'media': media,
        'is_owner': isOwner,
        'has_liked': hasLiked,
        'has_saved': hasSaved,
        'has_reposted': hasReposted,
        'reply_to': replyTo?.toJson(),
        'offset_id': offsetId,
        'owner': owner?.toJson(),
      };
}

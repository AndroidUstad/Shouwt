import 'media.dart';

class Swift {
  // List<dynamic>? views;
  String? time;
  String? type;
  String? status;
  Media? media;
  int? expTime;
  String? text;
  int? seen;
  String? swid;

  Swift({
    // this.views,
    this.time,
    this.type,
    this.status,
    this.media,
    this.expTime,
    this.text,
    this.seen,
    this.swid,
  });

  factory Swift.fromJson(Map<String, dynamic> json) => Swift(
        // views: json['views'] as List<dynamic>?,
        time: json['time'] as String?,
        type: json['type'] as String?,
        status: json['status'] as String?,
        media: json['media'] == null
            ? null
            : Media.fromJson(json['media'] as Map<String, dynamic>),
        expTime: json['exp_time'] as int?,
        text: json['text'] as String?,
        seen: json['seen'] as int?,
        swid: json['swid'] as String?,
      );

  Map<String, dynamic> toJson() => {
        // 'views': views,
        'time': time,
        'type': type,
        'status': status,
        'media': media?.toJson(),
        'exp_time': expTime,
        'text': text,
        'seen': seen,
        'swid': swid,
      };
}

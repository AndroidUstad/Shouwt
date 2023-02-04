class Data {
  bool? repost;

  Data({this.repost});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        repost: json['repost'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'repost': repost,
      };
}

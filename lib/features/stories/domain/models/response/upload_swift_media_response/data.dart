class Data {
  String? url;
  String? type;

  Data({this.url, this.type});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        url: json['url'] as String?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'type': type,
      };
}

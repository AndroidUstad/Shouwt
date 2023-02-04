class Media {
  String? src;

  Media({this.src});

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        src: json['src'] ?? json['source'],
      );

  Map<String, dynamic> toJson() => {
        'src': src,
      };
}

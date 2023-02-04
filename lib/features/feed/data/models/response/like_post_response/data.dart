class Data {
  bool? like;

  Data({this.like});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        like: json['like'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'like': like,
      };
}

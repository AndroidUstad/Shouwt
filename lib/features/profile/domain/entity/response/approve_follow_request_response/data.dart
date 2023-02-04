class Data {
  int? total;

  Data({this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json['total'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'total': total,
      };
}

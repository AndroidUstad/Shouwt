// ignore_for_file: public_member_api_docs, sort_constructors_first

class FetchFollowRequestsModel {
  final int offset;
  final int pageSize;
  FetchFollowRequestsModel({required this.offset, required this.pageSize});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'offset': offset,
      'page_size': pageSize,
    };
  }
}

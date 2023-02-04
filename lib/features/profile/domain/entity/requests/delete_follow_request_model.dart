import 'dart:collection';

class DeleteFollowRequestModel {
  final int reqId;
  DeleteFollowRequestModel({required this.reqId});

  HashMap<String, dynamic> toMap() => HashMap.from({'req_id': reqId});
}

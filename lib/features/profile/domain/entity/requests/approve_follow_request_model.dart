// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:collection';

class ApproveFollowRequestModel {
  final int reqId;
  ApproveFollowRequestModel({required this.reqId});

  HashMap<String, dynamic> toMap() => HashMap.from({'req_id': reqId});
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:collection';

class DeleteSwiftRequest {
  final String swid;
  DeleteSwiftRequest({required this.swid});

  HashMap<String, dynamic> toHashMap() => HashMap.from({'swid': swid});

  @override
  String toString() => 'DeleteSwiftRequest(swid: $swid)';
}

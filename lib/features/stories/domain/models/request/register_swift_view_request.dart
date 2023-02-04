// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:collection';

class RegisterSwiftViewRequest {
  final String userId;
  final String swid;
  RegisterSwiftViewRequest({
    required this.userId,
    required this.swid,
  });

  HashMap<String, dynamic> toMap() {
    return HashMap.from({
      'user_id': userId,
      'swid': swid,
    });
  }
}

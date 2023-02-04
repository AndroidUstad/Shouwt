import 'dart:collection';

class DeleteAccountRequest {
  final String password;
  DeleteAccountRequest({required this.password});

  HashMap<String, dynamic> toMap() => HashMap.from({'password': password});
}

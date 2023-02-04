import 'dart:collection';

class ChnagePasswordRequest {
  final String oldPassword;
  final String newPassword;

  ChnagePasswordRequest({required this.oldPassword, required this.newPassword});
  HashMap<String, dynamic> toMap() =>
      HashMap.from({"old_password": oldPassword, "new_password": newPassword});
}

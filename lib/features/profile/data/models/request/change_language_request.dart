// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:collection';

class ChangeLanguageRequest {
  final String langeName;
  ChangeLanguageRequest({required this.langeName});

  HashMap<String, dynamic> toMap() {
    return HashMap.from({'lang_name': langeName});
  }
}

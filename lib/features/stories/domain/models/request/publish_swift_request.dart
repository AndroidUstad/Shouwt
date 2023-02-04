import 'dart:collection';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class PublishSwiftRequest {
  final String swiftText;
  PublishSwiftRequest({
    required this.swiftText,
  });

  HashMap<String, dynamic> toMap() {
    return HashMap.from({
      'swift_text': swiftText,
    });
  }
}

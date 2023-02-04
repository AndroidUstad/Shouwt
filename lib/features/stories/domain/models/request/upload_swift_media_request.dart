// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:dio/dio.dart';

class UploadSwiftMediaRequest {
  final String type;
  final MultipartFile file;
  UploadSwiftMediaRequest({
    required this.type,
    required this.file,
  });

  HashMap<String, dynamic> toMap() {
    return HashMap.from({'type': type, 'file': file});
  }

  @override
  String toString() => 'UploadSwiftMediaRequest(type: $type, file: $file)';
}

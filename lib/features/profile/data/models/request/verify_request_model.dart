import 'dart:collection';

import '../../../../../extensions.dart';

class VerifyUserReqest {
  final String message;
  final String video;
  final String fullName;

  VerifyUserReqest(
      {required this.message, required this.video, required this.fullName});

  Future<HashMap<String, dynamic>> get toMap async => HashMap.from({
        "text_message": message,
        "video_message": await video.toMultiPart(),
        "full_name": fullName,
      });
}

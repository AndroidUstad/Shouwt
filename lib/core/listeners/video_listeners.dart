import '../extensions/context_exrensions.dart';
import '../../features/posts/data/model/response/reply_to_post_response/reply_to_post_response.dart';
import 'package:flutter/material.dart';

class VideoListeners {
  static Future<Null> success(dynamic state, BuildContext context) async {
    if (state is ReplyToPostResponse) {
      context.showSnackBar(message: 'Reply Posted');
    }
  }

  static Null error(String error, BuildContext context) {
    context.showSnackBar(isError: true, message: error);
  }
}

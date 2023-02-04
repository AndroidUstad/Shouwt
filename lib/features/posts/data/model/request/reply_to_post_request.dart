import 'dart:collection';

class ReplyToPostRequest {
  final String postText;
  final int threadId;
  final String? gifSrc;
  ReplyToPostRequest({
    required this.postText,
    required this.threadId,
    this.gifSrc,
  });

  HashMap<String, dynamic> toMap() {
    return HashMap.from({
      'post_text': postText,
      'thread_id': threadId,
      'gif_src': gifSrc,
    });
  }
}

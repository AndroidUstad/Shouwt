import 'package:auto_route/auto_route.dart';
import '../../features/stories/domain/models/response/delete_swift_response.dart';
import '../extensions/context_exrensions.dart';
import 'package:flutter/cupertino.dart';
import '../../features/stories/domain/models/response/publish_swift_response.dart';

class StoriesListener {
  static Future<Null> success(dynamic state, BuildContext context) async {
    if (state is PublishSwiftResponse) {
      context.router.pop().whenComplete(
            () => context.showSnackBar(message: state.message),
          );
    } else if (state is DeleteSwiftResponse) {
      context.showSnackBar(message: 'Swift deleted successfully');
    }
  }

  static Null error(String error, BuildContext context) {
    context.showSnackBar(isError: true, message: error);
  }
}

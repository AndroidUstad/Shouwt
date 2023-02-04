import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'dart:async';
import 'extensions/string_extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'common/media/media_data.dart';
import 'extensions/color_extension.dart';

class HelperFunctions {
  static void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  static bool isEmptyTextField(
    TextEditingController controller,
    List<MediaData> mediaItems,
  ) {
    bool isEmptyTextField = true;
    controller.addListener(() {
      isEmptyTextField = controller.text.isEmpty;
    });
    bool isMediaEmpty = mediaItems.isEmpty;
    return isEmptyTextField && isMediaEmpty;
  }

  static String generateRandomString(int len) {
    var r = math.Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  static Future<Color?> getColorFromVideo(String video) async {
    final file = await VideoThumbnail.thumbnailFile(
      video: video,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 64,
      quality: 75,
    );
    if (file == null) return HexColor.fromHex('#24282E');

    final imageProvider = Image.file(File(file)).image;

    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    log('COLOR IS ${paletteGenerator.dominantColor?.color}');
    return paletteGenerator.dominantColor?.color;
  }

  static Future<Size> calculateImageDimension(String thumbnail) {
    Completer<Size> completer = Completer();
    Image image = Image.network(thumbnail.makeValidUrl);
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }
}

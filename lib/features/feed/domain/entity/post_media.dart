import '../../../../config/strings.dart';
import '../../data/models/feeds_response.dart';
import '../../presentation/widgets/create_post_card.dart';
import '../../../../extensions.dart';
import '../../../messages/domain/entity/chat_entity.dart';
import '../../../profile/data/models/response/profile_posts_response.dart';

class PostMedia {
  final MediaTypeEnum? mediaType;
  final String? url;
  final String? thumbnail;

  const PostMedia._({
    this.mediaType,
    this.url,
    this.thumbnail,
  });

  factory PostMedia.fromChatEntity(ChatEntity chatEntity) {
    return PostMedia._(
        url: chatEntity.profileUrl, mediaType: MediaTypeEnum.IMAGE);
  }
  factory PostMedia.fromFeed(FeedMedia media) {
    return PostMedia._(
      mediaType: media.src!.getMediaType,
      url: _makeValidUrl(media.src!),
      thumbnail: media.thumbnail,
    );
  }

  factory PostMedia.fromProfilePostMedia(ProfilePostMedia media) {
    return PostMedia._(
      mediaType: media.src!.getMediaType,
      url: _makeValidUrl(media.src!),
      thumbnail: media.x != null && media.x.isNotEmpty
          ? media.x['poster_thumb']
          : null,
    );
  }
  static String _makeValidUrl(String url) {
    if (!url.contains("https")) {
      return Strings.baseMediaUrl + url;
    }
    return url;
  }
}

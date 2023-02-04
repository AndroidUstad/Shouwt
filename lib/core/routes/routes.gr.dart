// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i21;
import 'package:flutter/material.dart' as _i22;

import '../../features/authentication/presentation/pages/login_screen.dart'
    as _i3;
import '../../features/authentication/presentation/pages/reset_password_screen.dart'
    as _i4;
import '../../features/authentication/presentation/pages/signup_screen.dart'
    as _i2;
import '../../features/feed/domain/entity/post_entity.dart' as _i23;
import '../../features/feed/presentation/pages/feed_screen.dart' as _i7;
import '../../features/feed/presentation/widgets/camera/camera_view_confirmation_screen.dart'
    as _i20;
import '../../features/messages/domain/entity/message_entity.dart' as _i25;
import '../../features/messages/presentation/pages/chat_screen.dart' as _i10;
import '../../features/posts/domain/entiity/reply_entity.dart' as _i24;
import '../../features/posts/presentation/pages/create_post.dart' as _i9;
import '../../features/posts/presentation/pages/view_post_screen.dart' as _i11;
import '../../features/profile/domain/entity/profile_entity.dart' as _i26;
import '../../features/profile/presentation/pages/followers_following_screen.dart'
    as _i12;
import '../../features/profile/presentation/pages/profile_screen.dart' as _i8;
import '../../features/profile/presentation/pages/settings/settings_screen.dart'
    as _i14;
import '../../features/search/presentation/pages/searh_screen.dart' as _i13;
import '../../features/stories/domain/models/response/get_swifts_list_response/datum.dart'
    as _i27;
import '../../features/stories/presentation/pages/camera/stories_camera_screen.dart'
    as _i17;
import '../../features/stories/presentation/pages/camera/video_viewer_screen.dart'
    as _i18;
import '../../features/stories/presentation/pages/select_media_for_story_screen.dart'
    as _i15;
import '../../features/stories/presentation/pages/story_image_viewer.dart'
    as _i16;
import '../../features/stories/presentation/pages/view_story_screen.dart'
    as _i19;
import '../../features/welcome/welcome_screen.dart' as _i1;
import '../common/error_screen.dart' as _i6;
import '../common/widget/web_view_screen.dart' as _i5;

class MyRouter extends _i21.RootStackRouter {
  MyRouter([_i22.GlobalKey<_i22.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i21.PageFactory> pagesMap = {
    WelcomeScreenRoute.name: (routeData) {
      return _i21.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i1.WelcomeScreen(),
      );
    },
    SignUpScreenRoute.name: (routeData) {
      return _i21.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i2.SignUpScreen(),
      );
    },
    LoginScreenRoute.name: (routeData) {
      return _i21.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i3.LoginScreen(),
      );
    },
    ResetPasswordScreenRoute.name: (routeData) {
      return _i21.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i4.ResetPasswordScreen(),
      );
    },
    WebViewScreenRoute.name: (routeData) {
      final args = routeData.argsAs<WebViewScreenRouteArgs>(
          orElse: () => const WebViewScreenRouteArgs());
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.WebViewScreen(
          key: args.key,
          url: args.url,
          name: args.name,
        ),
      );
    },
    ErrorScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ErrorScreenRouteArgs>(
          orElse: () => const ErrorScreenRouteArgs());
      return _i21.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i6.ErrorScreen(
          key: args.key,
          error: args.error,
        ),
      );
    },
    FeedScreenRoute.name: (routeData) {
      return _i21.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i7.FeedScreen(),
      );
    },
    ProfileScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileScreenRouteArgs>(
          orElse: () => const ProfileScreenRouteArgs());
      return _i21.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i8.ProfileScreen(
          key: args.key,
          otherUserId: args.otherUserId,
          profileUrl: args.profileUrl,
          coverUrl: args.coverUrl,
          profileNavigationEnum: args.profileNavigationEnum,
        ),
      );
    },
    CreatePostRoute.name: (routeData) {
      final args = routeData.argsAs<CreatePostRouteArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.CreatePost(
          key: args.key,
          isCreatePost: args.isCreatePost,
          title: args.title,
          replyTo: args.replyTo,
          threadId: args.threadId,
          onClickAction: args.onClickAction,
          postEntity: args.postEntity,
          replyEntity: args.replyEntity,
          backData: args.backData,
        ),
        fullscreenDialog: true,
      );
    },
    ChatScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ChatScreenRouteArgs>(
          orElse: () => const ChatScreenRouteArgs());
      return _i21.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i10.ChatScreen(
          key: args.key,
          otherPersonUserId: args.otherPersonUserId,
          otherUserFullName: args.otherUserFullName,
          otherPersonProfileUrl: args.otherPersonProfileUrl,
          entity: args.entity,
        ),
      );
    },
    ViewPostScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ViewPostScreenRouteArgs>();
      return _i21.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i11.ViewPostScreen(
          key: args.key,
          threadID: args.threadID,
          postEntity: args.postEntity,
        ),
      );
    },
    FollowingFollowersScreenRoute.name: (routeData) {
      final args = routeData.argsAs<FollowingFollowersScreenRouteArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.FollowingFollowersScreen(
          key: args.key,
          followScreenEnum: args.followScreenEnum,
          userId: args.userId,
          profileEntity: args.profileEntity,
        ),
        fullscreenDialog: true,
      );
    },
    SearchScreenRoute.name: (routeData) {
      final args = routeData.argsAs<SearchScreenRouteArgs>(
          orElse: () => const SearchScreenRouteArgs());
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.SearchScreen(
          key: args.key,
          searchedText: args.searchedText,
        ),
      );
    },
    SettingsScreenRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i14.SettingsScreen(),
      );
    },
    SelectMediaForStoryScreenRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.SelectMediaForStoryScreen(),
      );
    },
    StoryImageViewerRoute.name: (routeData) {
      final args = routeData.argsAs<StoryImageViewerRouteArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.StoryImageViewer(
          key: args.key,
          isVideo: args.isVideo,
          src: args.src,
        ),
      );
    },
    StoriesCameraScreenRoute.name: (routeData) {
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i17.StoriesCameraScreen(),
      );
    },
    VideoViewerScreenRoute.name: (routeData) {
      final args = routeData.argsAs<VideoViewerScreenRouteArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i18.VideoViewerScreen(
          args.videoPath,
          key: args.key,
        ),
      );
    },
    ViewStoryScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ViewStoryScreenRouteArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i19.ViewStoryScreen(
          args.swift,
          key: args.key,
        ),
      );
    },
    CameraViewConfirmationScreenRoute.name: (routeData) {
      final args = routeData.argsAs<CameraViewConfirmationScreenRouteArgs>();
      return _i21.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i20.CameraViewConfirmationScreen(
          args.image,
          key: args.key,
          onCropped: args.onCropped,
        ),
      );
    },
  };

  @override
  List<_i21.RouteConfig> get routes => [
        _i21.RouteConfig(
          WelcomeScreenRoute.name,
          path: '/welcome-screen',
        ),
        _i21.RouteConfig(
          SignUpScreenRoute.name,
          path: '/sign-up-screen',
        ),
        _i21.RouteConfig(
          LoginScreenRoute.name,
          path: '/login-screen',
        ),
        _i21.RouteConfig(
          ResetPasswordScreenRoute.name,
          path: '/reset-password-screen',
        ),
        _i21.RouteConfig(
          WebViewScreenRoute.name,
          path: '/web-view-screen',
        ),
        _i21.RouteConfig(
          ErrorScreenRoute.name,
          path: '/error-screen',
        ),
        _i21.RouteConfig(
          FeedScreenRoute.name,
          path: '/feed-screen',
        ),
        _i21.RouteConfig(
          ProfileScreenRoute.name,
          path: '/profile-screen',
        ),
        _i21.RouteConfig(
          CreatePostRoute.name,
          path: '/create-post',
        ),
        _i21.RouteConfig(
          ChatScreenRoute.name,
          path: '/chat-screen',
        ),
        _i21.RouteConfig(
          ViewPostScreenRoute.name,
          path: '/view-post-screen',
        ),
        _i21.RouteConfig(
          FollowingFollowersScreenRoute.name,
          path: '/following-followers-screen',
        ),
        _i21.RouteConfig(
          SearchScreenRoute.name,
          path: '/search-screen',
        ),
        _i21.RouteConfig(
          SettingsScreenRoute.name,
          path: '/settings-screen',
        ),
        _i21.RouteConfig(
          SelectMediaForStoryScreenRoute.name,
          path: '/select-media-for-story-screen',
        ),
        _i21.RouteConfig(
          StoryImageViewerRoute.name,
          path: '/story-image-viewer',
        ),
        _i21.RouteConfig(
          StoriesCameraScreenRoute.name,
          path: '/stories-camera-screen',
        ),
        _i21.RouteConfig(
          VideoViewerScreenRoute.name,
          path: '/video-viewer-screen',
        ),
        _i21.RouteConfig(
          ViewStoryScreenRoute.name,
          path: '/view-story-screen',
        ),
        _i21.RouteConfig(
          CameraViewConfirmationScreenRoute.name,
          path: '/camera-view-confirmation-screen',
        ),
      ];
}

/// generated route for
/// [_i1.WelcomeScreen]
class WelcomeScreenRoute extends _i21.PageRouteInfo<void> {
  const WelcomeScreenRoute()
      : super(
          WelcomeScreenRoute.name,
          path: '/welcome-screen',
        );

  static const String name = 'WelcomeScreenRoute';
}

/// generated route for
/// [_i2.SignUpScreen]
class SignUpScreenRoute extends _i21.PageRouteInfo<void> {
  const SignUpScreenRoute()
      : super(
          SignUpScreenRoute.name,
          path: '/sign-up-screen',
        );

  static const String name = 'SignUpScreenRoute';
}

/// generated route for
/// [_i3.LoginScreen]
class LoginScreenRoute extends _i21.PageRouteInfo<void> {
  const LoginScreenRoute()
      : super(
          LoginScreenRoute.name,
          path: '/login-screen',
        );

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i4.ResetPasswordScreen]
class ResetPasswordScreenRoute extends _i21.PageRouteInfo<void> {
  const ResetPasswordScreenRoute()
      : super(
          ResetPasswordScreenRoute.name,
          path: '/reset-password-screen',
        );

  static const String name = 'ResetPasswordScreenRoute';
}

/// generated route for
/// [_i5.WebViewScreen]
class WebViewScreenRoute extends _i21.PageRouteInfo<WebViewScreenRouteArgs> {
  WebViewScreenRoute({
    _i22.Key? key,
    String? url,
    String? name,
  }) : super(
          WebViewScreenRoute.name,
          path: '/web-view-screen',
          args: WebViewScreenRouteArgs(
            key: key,
            url: url,
            name: name,
          ),
        );

  static const String name = 'WebViewScreenRoute';
}

class WebViewScreenRouteArgs {
  const WebViewScreenRouteArgs({
    this.key,
    this.url,
    this.name,
  });

  final _i22.Key? key;

  final String? url;

  final String? name;

  @override
  String toString() {
    return 'WebViewScreenRouteArgs{key: $key, url: $url, name: $name}';
  }
}

/// generated route for
/// [_i6.ErrorScreen]
class ErrorScreenRoute extends _i21.PageRouteInfo<ErrorScreenRouteArgs> {
  ErrorScreenRoute({
    _i22.Key? key,
    String? error,
  }) : super(
          ErrorScreenRoute.name,
          path: '/error-screen',
          args: ErrorScreenRouteArgs(
            key: key,
            error: error,
          ),
        );

  static const String name = 'ErrorScreenRoute';
}

class ErrorScreenRouteArgs {
  const ErrorScreenRouteArgs({
    this.key,
    this.error,
  });

  final _i22.Key? key;

  final String? error;

  @override
  String toString() {
    return 'ErrorScreenRouteArgs{key: $key, error: $error}';
  }
}

/// generated route for
/// [_i7.FeedScreen]
class FeedScreenRoute extends _i21.PageRouteInfo<void> {
  const FeedScreenRoute()
      : super(
          FeedScreenRoute.name,
          path: '/feed-screen',
        );

  static const String name = 'FeedScreenRoute';
}

/// generated route for
/// [_i8.ProfileScreen]
class ProfileScreenRoute extends _i21.PageRouteInfo<ProfileScreenRouteArgs> {
  ProfileScreenRoute({
    _i22.Key? key,
    String? otherUserId,
    String? profileUrl,
    String? coverUrl,
    _i8.ProfileNavigationEnum profileNavigationEnum =
        _i8.ProfileNavigationEnum.FROM_FEED,
  }) : super(
          ProfileScreenRoute.name,
          path: '/profile-screen',
          args: ProfileScreenRouteArgs(
            key: key,
            otherUserId: otherUserId,
            profileUrl: profileUrl,
            coverUrl: coverUrl,
            profileNavigationEnum: profileNavigationEnum,
          ),
        );

  static const String name = 'ProfileScreenRoute';
}

class ProfileScreenRouteArgs {
  const ProfileScreenRouteArgs({
    this.key,
    this.otherUserId,
    this.profileUrl,
    this.coverUrl,
    this.profileNavigationEnum = _i8.ProfileNavigationEnum.FROM_FEED,
  });

  final _i22.Key? key;

  final String? otherUserId;

  final String? profileUrl;

  final String? coverUrl;

  final _i8.ProfileNavigationEnum profileNavigationEnum;

  @override
  String toString() {
    return 'ProfileScreenRouteArgs{key: $key, otherUserId: $otherUserId, profileUrl: $profileUrl, coverUrl: $coverUrl, profileNavigationEnum: $profileNavigationEnum}';
  }
}

/// generated route for
/// [_i9.CreatePost]
class CreatePostRoute extends _i21.PageRouteInfo<CreatePostRouteArgs> {
  CreatePostRoute({
    _i22.Key? key,
    required bool isCreatePost,
    String title = "Create Post",
    String? replyTo = "",
    String? threadId,
    Function? onClickAction,
    _i23.PostEntity? postEntity,
    _i24.ReplyEntity? replyEntity,
    Function? backData,
  }) : super(
          CreatePostRoute.name,
          path: '/create-post',
          args: CreatePostRouteArgs(
            key: key,
            isCreatePost: isCreatePost,
            title: title,
            replyTo: replyTo,
            threadId: threadId,
            onClickAction: onClickAction,
            postEntity: postEntity,
            replyEntity: replyEntity,
            backData: backData,
          ),
        );

  static const String name = 'CreatePostRoute';
}

class CreatePostRouteArgs {
  const CreatePostRouteArgs({
    this.key,
    required this.isCreatePost,
    this.title = "Create Post",
    this.replyTo = "",
    this.threadId,
    this.onClickAction,
    this.postEntity,
    this.replyEntity,
    this.backData,
  });

  final _i22.Key? key;

  final bool isCreatePost;

  final String title;

  final String? replyTo;

  final String? threadId;

  final Function? onClickAction;

  final _i23.PostEntity? postEntity;

  final _i24.ReplyEntity? replyEntity;

  final Function? backData;

  @override
  String toString() {
    return 'CreatePostRouteArgs{key: $key, isCreatePost: $isCreatePost, title: $title, replyTo: $replyTo, threadId: $threadId, onClickAction: $onClickAction, postEntity: $postEntity, replyEntity: $replyEntity, backData: $backData}';
  }
}

/// generated route for
/// [_i10.ChatScreen]
class ChatScreenRoute extends _i21.PageRouteInfo<ChatScreenRouteArgs> {
  ChatScreenRoute({
    _i22.Key? key,
    String? otherPersonUserId,
    String? otherUserFullName,
    String? otherPersonProfileUrl,
    _i25.MessageEntity? entity,
  }) : super(
          ChatScreenRoute.name,
          path: '/chat-screen',
          args: ChatScreenRouteArgs(
            key: key,
            otherPersonUserId: otherPersonUserId,
            otherUserFullName: otherUserFullName,
            otherPersonProfileUrl: otherPersonProfileUrl,
            entity: entity,
          ),
        );

  static const String name = 'ChatScreenRoute';
}

class ChatScreenRouteArgs {
  const ChatScreenRouteArgs({
    this.key,
    this.otherPersonUserId,
    this.otherUserFullName,
    this.otherPersonProfileUrl,
    this.entity,
  });

  final _i22.Key? key;

  final String? otherPersonUserId;

  final String? otherUserFullName;

  final String? otherPersonProfileUrl;

  final _i25.MessageEntity? entity;

  @override
  String toString() {
    return 'ChatScreenRouteArgs{key: $key, otherPersonUserId: $otherPersonUserId, otherUserFullName: $otherUserFullName, otherPersonProfileUrl: $otherPersonProfileUrl, entity: $entity}';
  }
}

/// generated route for
/// [_i11.ViewPostScreen]
class ViewPostScreenRoute extends _i21.PageRouteInfo<ViewPostScreenRouteArgs> {
  ViewPostScreenRoute({
    _i22.Key? key,
    int? threadID,
    required _i23.PostEntity? postEntity,
  }) : super(
          ViewPostScreenRoute.name,
          path: '/view-post-screen',
          args: ViewPostScreenRouteArgs(
            key: key,
            threadID: threadID,
            postEntity: postEntity,
          ),
        );

  static const String name = 'ViewPostScreenRoute';
}

class ViewPostScreenRouteArgs {
  const ViewPostScreenRouteArgs({
    this.key,
    this.threadID,
    required this.postEntity,
  });

  final _i22.Key? key;

  final int? threadID;

  final _i23.PostEntity? postEntity;

  @override
  String toString() {
    return 'ViewPostScreenRouteArgs{key: $key, threadID: $threadID, postEntity: $postEntity}';
  }
}

/// generated route for
/// [_i12.FollowingFollowersScreen]
class FollowingFollowersScreenRoute
    extends _i21.PageRouteInfo<FollowingFollowersScreenRouteArgs> {
  FollowingFollowersScreenRoute({
    _i22.Key? key,
    _i12.FollowUnFollowScreenEnum followScreenEnum =
        _i12.FollowUnFollowScreenEnum.FOLLOWERS,
    String? userId,
    required _i26.ProfileEntity profileEntity,
  }) : super(
          FollowingFollowersScreenRoute.name,
          path: '/following-followers-screen',
          args: FollowingFollowersScreenRouteArgs(
            key: key,
            followScreenEnum: followScreenEnum,
            userId: userId,
            profileEntity: profileEntity,
          ),
        );

  static const String name = 'FollowingFollowersScreenRoute';
}

class FollowingFollowersScreenRouteArgs {
  const FollowingFollowersScreenRouteArgs({
    this.key,
    this.followScreenEnum = _i12.FollowUnFollowScreenEnum.FOLLOWERS,
    this.userId,
    required this.profileEntity,
  });

  final _i22.Key? key;

  final _i12.FollowUnFollowScreenEnum followScreenEnum;

  final String? userId;

  final _i26.ProfileEntity profileEntity;

  @override
  String toString() {
    return 'FollowingFollowersScreenRouteArgs{key: $key, followScreenEnum: $followScreenEnum, userId: $userId, profileEntity: $profileEntity}';
  }
}

/// generated route for
/// [_i13.SearchScreen]
class SearchScreenRoute extends _i21.PageRouteInfo<SearchScreenRouteArgs> {
  SearchScreenRoute({
    _i22.Key? key,
    String? searchedText,
  }) : super(
          SearchScreenRoute.name,
          path: '/search-screen',
          args: SearchScreenRouteArgs(
            key: key,
            searchedText: searchedText,
          ),
        );

  static const String name = 'SearchScreenRoute';
}

class SearchScreenRouteArgs {
  const SearchScreenRouteArgs({
    this.key,
    this.searchedText,
  });

  final _i22.Key? key;

  final String? searchedText;

  @override
  String toString() {
    return 'SearchScreenRouteArgs{key: $key, searchedText: $searchedText}';
  }
}

/// generated route for
/// [_i14.SettingsScreen]
class SettingsScreenRoute extends _i21.PageRouteInfo<void> {
  const SettingsScreenRoute()
      : super(
          SettingsScreenRoute.name,
          path: '/settings-screen',
        );

  static const String name = 'SettingsScreenRoute';
}

/// generated route for
/// [_i15.SelectMediaForStoryScreen]
class SelectMediaForStoryScreenRoute extends _i21.PageRouteInfo<void> {
  const SelectMediaForStoryScreenRoute()
      : super(
          SelectMediaForStoryScreenRoute.name,
          path: '/select-media-for-story-screen',
        );

  static const String name = 'SelectMediaForStoryScreenRoute';
}

/// generated route for
/// [_i16.StoryImageViewer]
class StoryImageViewerRoute
    extends _i21.PageRouteInfo<StoryImageViewerRouteArgs> {
  StoryImageViewerRoute({
    _i22.Key? key,
    required bool isVideo,
    required String src,
  }) : super(
          StoryImageViewerRoute.name,
          path: '/story-image-viewer',
          args: StoryImageViewerRouteArgs(
            key: key,
            isVideo: isVideo,
            src: src,
          ),
        );

  static const String name = 'StoryImageViewerRoute';
}

class StoryImageViewerRouteArgs {
  const StoryImageViewerRouteArgs({
    this.key,
    required this.isVideo,
    required this.src,
  });

  final _i22.Key? key;

  final bool isVideo;

  final String src;

  @override
  String toString() {
    return 'StoryImageViewerRouteArgs{key: $key, isVideo: $isVideo, src: $src}';
  }
}

/// generated route for
/// [_i17.StoriesCameraScreen]
class StoriesCameraScreenRoute extends _i21.PageRouteInfo<void> {
  const StoriesCameraScreenRoute()
      : super(
          StoriesCameraScreenRoute.name,
          path: '/stories-camera-screen',
        );

  static const String name = 'StoriesCameraScreenRoute';
}

/// generated route for
/// [_i18.VideoViewerScreen]
class VideoViewerScreenRoute
    extends _i21.PageRouteInfo<VideoViewerScreenRouteArgs> {
  VideoViewerScreenRoute({
    required String videoPath,
    _i22.Key? key,
  }) : super(
          VideoViewerScreenRoute.name,
          path: '/video-viewer-screen',
          args: VideoViewerScreenRouteArgs(
            videoPath: videoPath,
            key: key,
          ),
        );

  static const String name = 'VideoViewerScreenRoute';
}

class VideoViewerScreenRouteArgs {
  const VideoViewerScreenRouteArgs({
    required this.videoPath,
    this.key,
  });

  final String videoPath;

  final _i22.Key? key;

  @override
  String toString() {
    return 'VideoViewerScreenRouteArgs{videoPath: $videoPath, key: $key}';
  }
}

/// generated route for
/// [_i19.ViewStoryScreen]
class ViewStoryScreenRoute
    extends _i21.PageRouteInfo<ViewStoryScreenRouteArgs> {
  ViewStoryScreenRoute({
    required _i27.Datum swift,
    _i22.Key? key,
  }) : super(
          ViewStoryScreenRoute.name,
          path: '/view-story-screen',
          args: ViewStoryScreenRouteArgs(
            swift: swift,
            key: key,
          ),
        );

  static const String name = 'ViewStoryScreenRoute';
}

class ViewStoryScreenRouteArgs {
  const ViewStoryScreenRouteArgs({
    required this.swift,
    this.key,
  });

  final _i27.Datum swift;

  final _i22.Key? key;

  @override
  String toString() {
    return 'ViewStoryScreenRouteArgs{swift: $swift, key: $key}';
  }
}

/// generated route for
/// [_i20.CameraViewConfirmationScreen]
class CameraViewConfirmationScreenRoute
    extends _i21.PageRouteInfo<CameraViewConfirmationScreenRouteArgs> {
  CameraViewConfirmationScreenRoute({
    required String image,
    _i22.Key? key,
    required void Function(String)? onCropped,
  }) : super(
          CameraViewConfirmationScreenRoute.name,
          path: '/camera-view-confirmation-screen',
          args: CameraViewConfirmationScreenRouteArgs(
            image: image,
            key: key,
            onCropped: onCropped,
          ),
        );

  static const String name = 'CameraViewConfirmationScreenRoute';
}

class CameraViewConfirmationScreenRouteArgs {
  const CameraViewConfirmationScreenRouteArgs({
    required this.image,
    this.key,
    required this.onCropped,
  });

  final String image;

  final _i22.Key? key;

  final void Function(String)? onCropped;

  @override
  String toString() {
    return 'CameraViewConfirmationScreenRouteArgs{image: $image, key: $key, onCropped: $onCropped}';
  }
}

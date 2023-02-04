import 'package:colibri/core/common/usecase.dart';
import 'package:colibri/core/datasource/local_data_source.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/stories/domain/models/request/delete_swift_request.dart';
import 'package:colibri/features/stories/domain/models/request/register_swift_view_request.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/di/injection.dart';
import '../../domain/models/response/get_swifts_list_response/get_swifts_list_response.dart';
import '../../domain/usecase/delete_swift_media_usecase.dart';
import '../../domain/usecase/delete_swift_usecase.dart';
import '../../domain/usecase/get_swift_list_usecase.dart';
import '../../domain/usecase/publish_swift_usecase.dart';
import '../../domain/usecase/register_swift_view_usecase.dart';
import '../../domain/usecase/upload_swift_media_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/uistate/common_ui_state.dart';
import '../../domain/models/request/publish_swift_request.dart';
import '../../domain/models/request/upload_swift_media_request.dart';

class StoriesBloc extends Cubit<CommonUIState> {
  final DeleteSwiftMediaUseCase _deleteSwiftMediaUseCase;
  final DeleteSwiftUseCase _deleteSwiftUseCase;
  final GetSwiftListUseCase _getSwiftListUseCase;
  final PublishSwiftUseCase _publishSwiftUseCase;
  final RegisterSwiftViewUseCase _registerSwiftViewUseCase;
  final UploadSwiftMediaUseCaes _uploadSwiftMediaUseCaes;

  StoriesBloc(
    this._deleteSwiftMediaUseCase,
    this._deleteSwiftUseCase,
    this._getSwiftListUseCase,
    this._publishSwiftUseCase,
    this._registerSwiftViewUseCase,
    this._uploadSwiftMediaUseCaes,
  ) : super(CommonUIState.initial());

  GetSwiftsListResponse? swifts;
  bool storyLoading = false;
  Duration storyTime = Duration(hours: 10);
  VideoPlayerController? videoController;

  void uploadSwiftImage(
    String media, {
    bool isVideo = false,
    String swiftText = '',
  }) async {
    emit(const CommonUIState.loading());
    final multiPartImage = await media.toMultiPart();
    final params = UploadSwiftMediaRequest(type: 'image', file: multiPartImage);
    final response = await _uploadSwiftMediaUseCaes(params);
    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (r) async {
        final publishResponse = await _publishSwiftUseCase(
          PublishSwiftRequest(swiftText: swiftText),
        );
        publishResponse.fold(
          (l) => emit(CommonUIState.error(l.errorMessage)),
          (r) {
            emit(CommonUIState.success(r));
            getSwifts();
          },
        );
      },
    );
  }

  void registerSwiftView(RegisterSwiftViewRequest params) async {
    final response = await _registerSwiftViewUseCase(params);
    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (r) => emit(CommonUIState.success('')),
    );
  }

  void getSwifts() async {
    emit(const CommonUIState.loading());
    final response = await _getSwiftListUseCase(NoParam());
    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (r) {
        swifts = r;
        emit(CommonUIState.success(r));
      },
    );
  }

  void uploadSwiftVideo(String video, {String swiftText = ''}) async {
    emit(const CommonUIState.loading());
    final multiPartVideo = await video.toMultiPart();
    final params = UploadSwiftMediaRequest(type: 'video', file: multiPartVideo);
    final response = await _uploadSwiftMediaUseCaes(params);
    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (r) async {
        final publishResponse = await _publishSwiftUseCase(
          PublishSwiftRequest(swiftText: swiftText),
        );
        publishResponse.fold(
          (l) => emit(CommonUIState.error(l.errorMessage)),
          (r) {
            emit(CommonUIState.success(r));
            getSwifts();
          },
        );
      },
    );
  }

  void deleteSwift(String swid) async {
    emit(const CommonUIState.initial());
    final response = await _deleteSwiftUseCase(DeleteSwiftRequest(swid: swid));
    response.fold(
      (l) => emit(CommonUIState.error(l.errorMessage)),
      (r) {
        int currentUserId =
            getIt<LocalDataSource>().getUserData()!.data!.user!.userId!;
        int userIndex =
            swifts!.data!.indexWhere((user) => user.id == currentUserId);
        swifts!.data![userIndex].swift!
            .removeWhere((swift) => swift.swid == swid);

        emit(CommonUIState.success(r));
      },
    );
  }
}

import 'main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/common/uistate/common_ui_state.dart';

class ApplicationCubit extends Cubit<CommonUIState> {
  ApplicationCubit() : super(const CommonUIState.initial());

  void changeDarkMode(bool flag) {
    emit(const CommonUIState.initial());
    isDark = flag;
    emit(const CommonUIState.success(''));
  }
}

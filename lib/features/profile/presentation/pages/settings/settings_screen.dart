import '../../../../../application_cubit.dart';
import '../../../../../config/colors.dart';
import '../../../../../core/common/uistate/common_ui_state.dart';
import '../../../../../core/listeners/settings_listeners.dart';
import '../../../../feed/presentation/widgets/link_fetch/default_circular_progress.dart';
import 'settings_screen_widget.dart';
import '../../widgets/settings/settings_app_bar.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/response/get_profile_settings_response/get_profile_settings_response.dart';
import '../../bloc/settings/user_setting_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  GetProfileSettingsResponse? cachedData;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserSettingCubit>(context).getUserSettings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationCubit, CommonUIState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: isDark ? AppColors.appBlackColor : Colors.white,
          appBar: SettingsAppBar(),
          body: BlocConsumer<UserSettingCubit, CommonUIState>(
            listener: (context, state) => state.maybeWhen(
              orElse: () => null,
              success: (state) => SettingsListener.success(state, context),
              error: (e) => SettingsListener.error(e!, context),
            ),
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => DefaultCircularProgress(),
                orElse: () => cachedData != null
                    ? SettingsScreenWidget(cachedData!)
                    : DefaultCircularProgress(),
                success: (data) {
                  if (data is GetProfileSettingsResponse) {
                    cachedData = data;
                    return SettingsScreenWidget(data);
                  } else if (cachedData != null) {
                    return SettingsScreenWidget(cachedData!);
                  } else
                    return DefaultCircularProgress();
                },
              );
            },
          ),
        );
      },
    );
  }
}

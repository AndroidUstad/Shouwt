import '../../../../../extensions.dart';
import '../../../data/models/response/get_profile_settings_response/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/strings.dart';
import '../../bloc/settings/user_setting_cubit.dart';

class SettingsScreenChangeUsernameSheet extends StatefulWidget {
  const SettingsScreenChangeUsernameSheet(this.user, {Key? key})
      : super(key: key);
  final Data user;

  @override
  State<SettingsScreenChangeUsernameSheet> createState() =>
      _SettingsScreenChangeUsernameSheetState();
}

class _SettingsScreenChangeUsernameSheetState
    extends State<SettingsScreenChangeUsernameSheet> {
  late final UserSettingCubit _userSettingsCubit;
  @override
  void initState() {
    super.initState();
    _userSettingsCubit = BlocProvider.of<UserSettingCubit>(context);
    _userSettingsCubit.firstNameController =
        TextEditingController(text: widget.user.firstName);
    _userSettingsCubit.lastNameController =
        TextEditingController(text: widget.user.lastName);
    _userSettingsCubit.usernameController =
        TextEditingController(text: widget.user.userName);
  }

  @override
  void dispose() {
    _userSettingsCubit.firstNameController?.dispose();
    _userSettingsCubit.lastNameController?.dispose();
    _userSettingsCubit.usernameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        11.toSizedBox,
        Strings.firstName
            .toTextField(controller: _userSettingsCubit.firstNameController),
        11.toSizedBox,
        Strings.lastName
            .toTextField(controller: _userSettingsCubit.lastNameController),
        10.toSizedBox,
        Strings.userName
            .toTextField(controller: _userSettingsCubit.usernameController)
      ],
    );
  }
}

import '../../../../../application_cubit.dart';
import '../../../../../config/colors.dart';
import '../../../../../core/common/uistate/common_ui_state.dart';
import '../../../../../extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/datasource/local_data_source.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../main.dart';

class UpdateDarkModeModel extends StatefulWidget {
  const UpdateDarkModeModel({Key? key}) : super(key: key);

  @override
  State<UpdateDarkModeModel> createState() => _UpdateDarkModeModelState();
}

class _UpdateDarkModeModelState extends State<UpdateDarkModeModel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationCubit, CommonUIState>(
      builder: (context, state) {
        return Column(
          children: [
            SmartSelect<String?>.single(
              choiceStyle: S2ChoiceStyle(
                titleStyle:
                    context.subTitle2.copyWith(fontWeight: FontWeight.w500),
              ),
              modalConfig: S2ModalConfig(
                title: 'Theme',
                headerStyle: S2ModalHeaderStyle(
                  textStyle: context.subTitle1.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  backgroundColor:
                      isDark ? AppColors.appBlackColor : Colors.white,
                ),
                style: S2ModalStyle(
                  backgroundColor:
                      isDark ? AppColors.appBlackColor : Colors.white,
                ),
              ),
              modalType: S2ModalType.bottomSheet,
              selectedValue: isDark ? 'Dark Theme' : 'Light Theme',
              onChange: (s) async {
                bool isDark = s.value! == 'Dark Theme';
                await getIt<LocalDataSource>().changeDarkMode(isDark);
                BlocProvider.of<ApplicationCubit>(context)
                    .changeDarkMode(isDark);
              },
              tileBuilder: (c, s) => ListTile(
                trailing:
                    const Icon(Icons.arrow_forward_ios_outlined, size: 14),
                onTap: s.showModal,
                title: 'Theme'.toSubTitle2(fontWeight: FontWeight.w500),
                subtitle: (isDark ? 'Dark Theme' : 'Light Theme')
                    .toCaption(fontWeight: FontWeight.w500),
              ),
              choiceItems: ['Dark Theme', 'Light Theme']
                  .map(
                    (e) => S2Choice(
                      value: e,
                      title: e,
                      style: S2ChoiceStyle(
                        titleStyle: TextStyle(
                            color: isDark ? Colors.white : Colors.black),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}

import 'package:colibri/core/common/uistate/common_ui_state.dart';
import 'package:colibri/features/stories/presentation/bloc/stories_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/colors.dart';
import '../../../../core/extensions/context_exrensions.dart';
import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../widgets/create_swift_circle.dart';
import '../widgets/view_swift_circle.dart';

class StoriesWidget extends StatelessWidget {
  const StoriesWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoriesBloc, CommonUIState>(
      builder: (context, state) {
        final swiftsList = BlocProvider.of<StoriesBloc>(context).swifts;
        return swiftsList == null
            ? Align(
                alignment: Alignment.centerLeft,
                child: CreateSwiftCircle(),
              )
            : Container(
                height: context.getScreenHeight * .12,
                color: isDark ? AppColors.appBlackColor : Colors.white,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: swiftsList.data!.length,
                  itemBuilder: (_, index) {
                    final data = swiftsList.data![index];
                    if (index == 0)
                      return Row(
                        children: [
                          CreateSwiftCircle(),
                          ViewSwiftCircle(data),
                        ],
                      );
                    return ViewSwiftCircle(data);
                  },
                ),
              );
      },
    );
  }
}

// import 'package:auto_route/auto_route.dart';
// import 'package:colibri/core/extensions/context_exrensions.dart';
// import 'package:colibri/core/extensions/string_extensions.dart';
// import 'package:colibri/core/extensions/widget_extensions.dart';
// import 'package:colibri/features/profile/data/models/response/privacy_response.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_awesome_select/flutter_awesome_select.dart';
// import '../../../../../config/colors.dart';
// import '../../../../../config/strings.dart';
// import '../../../../../core/common/buttons/custom_button.dart';
// import '../../../../../core/routes/routes.gr.dart';
// import '../../../../../main.dart';
// import '../../../domain/entity/privacy_widget_model.dart';
// import '../../../domain/entity/setting_entity.dart';

// class SettingsScreenAccountPrivacySheet extends StatefulWidget {
//   const SettingsScreenAccountPrivacySheet({Key? key}) : super(key: key);

//   @override
//   State<SettingsScreenAccountPrivacySheet> createState() =>
//       _SettingsScreenAccountPrivacySheetState();
// }

// class _SettingsScreenAccountPrivacySheetState
//     extends State<SettingsScreenAccountPrivacySheet> {
//   @override
//   Widget build(BuildContext context) {
//     final privacyModels = PrivacyWidgetModel.getPrivacyModels(
//       accountPrivacyEntity: AccountPrivacyEntity.fromResponse(
//           PrivacyModel(searchVisibility: true)),
//     );
//     return Container(
//       color: isDark ? AppColors.appBlackColor : Colors.white,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               child: ListTile(
//                 title: "Account Privacy".toSubTitle1(
//                     (url) =>
//                         context.router.root.push(WebViewScreenRoute(url: url)),
//                     fontWeight: FontWeight.w500),
//                 tileColor: AppColors.sfBgColor,
//               ),
//             ),
//             // generating lists with title and options
//             _generateItem(privacyModels.sublist(0, 2)),
//             _generateItem(privacyModels.sublist(2, 4)),
//             _generateItem(privacyModels.sublist(4, 6)),
//             CustomButton(text: "Save", onTap: () {}).toPadding(16)
//           ],
//         ),
//       ),
//     );
//   }

//   String _mapItemsToSelectedValue(
//     List<PrivacyWidgetModel> items,
//     SettingEntity data,
//   ) {
//     switch (items[0].privacyOptionEnum) {
//       case PrivacyOptionEnum.PROFILE_VISIBILITY:
//         return data.accountPrivacyEntity.canSeeMyPosts;

//       case PrivacyOptionEnum.CONTACT_PRIVACY:
//         return data.accountPrivacyEntity.canDMMe ?? Strings.privacyEveryOne;

//       case PrivacyOptionEnum.SEARCH_VISIBILITY:
//         return data.accountPrivacyEntity.showProfileInSearchEngine;
//     }
//   }

//   Widget _generateItem(List<PrivacyWidgetModel> items) {
//     return SmartSelect.single(
//         selectedValue: _mapItemsToSelectedValue(items, snapshot.data!),
//         modalStyle: const S2ModalStyle(
//           clipBehavior: Clip.hardEdge,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               top: Radius.circular(10),
//             ),
//           ),
//         ),
//         choiceConfig: S2ChoiceConfig(
//           style: S2ChoiceStyle(
//             titleStyle: context.subTitle2.copyWith(
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           useDivider: true,
//         ),
//         modalConfig: S2ModalConfig(
//           headerStyle: S2ModalHeaderStyle(
//             textStyle: context.subTitle1.copyWith(
//               fontWeight: FontWeight.w500,
//               color: isDark ? Colors.white : null,
//             ),
//           ),
//         ),
//         modalType: S2ModalType.bottomSheet,
//         choiceGrouped: false,
//         title: PrivacyWidgetModel.getEnumValue(items[0].privacyOptionEnum),
//         choiceItems: items
//             .map(
//               (e) => S2Choice(
//                 value: e.value,
//                 title: e.value,
//                 group: PrivacyWidgetModel.getEnumValue(
//                   e.privacyOptionEnum,
//                 ),
//               ),
//             )
//             .toList(),
//         onChange: (S2SingleSelected<String> s) =>
//             _onChange(s, snapshot.data, items),
//         choiceTitleBuilder: (
//           c,
//           S2SingleState<Object?> choice,
//           S2Choice<Object?> text,
//         ) =>
//             ListTile(
//               onTap: () {
//                 // text
//               },
//               title: text.title!.toSubTitle1(
//                   (url) =>
//                       context.router.root.push(WebViewScreenRoute(url: url)),
//                   fontWeight: FontWeight.w500),
//               tileColor: isDark ? null : AppColors.sfBgColor,
//             ),
//         tileBuilder: (c, S2SingleState<String?> s) {
//           String subtitle = '';
//           var settingItem = snapshot.data;
//           switch (items[0].privacyOptionEnum) {
//             case PrivacyOptionEnum.PROFILE_VISIBILITY:
//               subtitle = settingItem!.accountPrivacyEntity.canSeeMyPosts;

//               break;
//             case PrivacyOptionEnum.CONTACT_PRIVACY:
//               subtitle = settingItem!.accountPrivacyEntity.canDMMe ??
//                   Strings.privacyEveryOne;

//               break;
//             case PrivacyOptionEnum.SEARCH_VISIBILITY:
//               subtitle =
//                   settingItem!.accountPrivacyEntity.showProfileInSearchEngine;

//               break;
//           }
//           return ListTile(
//             onTap: () {
//               s.showModal();
//             },
//             title: PrivacyWidgetModel.getEnumValue(items[0].privacyOptionEnum)
//                 .toSubTitle2(fontWeight: FontWeight.w500),
//             subtitle: subtitle.toCaption(fontWeight: FontWeight.w500),
//             trailing: const Icon(
//               Icons.arrow_forward_ios_outlined,
//               size: 14,
//             ),
//           );
//         });
//   }
// }

enum PrivacyOptionEnum {
  PROFILE_VISIBILITY,
  CONTACT_PRIVACY,
  SEARCH_VISIBILITY
}

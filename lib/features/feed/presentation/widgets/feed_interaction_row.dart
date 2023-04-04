import 'dart:convert';

import 'package:colibri/features/authentication/data/models/login_response.dart';
import 'package:colibri/features/profile/domain/entity/profile_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../config/colors.dart';
import '../../../../core/theme/images.dart';
import '../../../../extensions.dart';
import '../../domain/entity/post_entity.dart';
import '../../../posts/domain/entiity/reply_entity.dart';
import '../../../posts/presentation/pages/create_post.dart';
import '../../../../translations/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;


class FeedInteractionRow extends StatelessWidget {
  final ProfileEntity? profileEntity;

  const FeedInteractionRow({
    Key? key,
    required this.postEntity,
    required this.onClickAction,
    required this.onLikeTap,
    required this.onTapRepost,
    required this.replyCountIncreased,
    this.profileEntity, LoginResponse? loginResponseFeed,
  }) : super(key: key);
  final PostEntity? postEntity;
  final Function? onClickAction;
  final Function? onLikeTap;
  final Function? onTapRepost;
  final Function(bool)? replyCountIncreased;

  @override
  Widget build(BuildContext context) {
    return [
      [
        InkWell(
          onTap: () async {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (c) => DraggableScrollableSheet(
                  initialChildSize: 1,
                  maxChildSize: 1,
                  minChildSize: 1,
                  expand: true,
                  builder: (BuildContext context, _) => Container(
                    margin: EdgeInsets.only(
                        top: MediaQueryData.fromWindow(
                          WidgetsBinding.instance.window,
                        ).padding.top),
                    child: CreatePost(
                      postEntity: postEntity,
                      onClickAction: onClickAction,
                      isCreatePost: false,
                      title: LocaleKeys.post_a_reply.tr(),
                      replyTo: postEntity!.userName,
                      threadId: postEntity!.postId,
                      replyEntity: ReplyEntity.fromPostEntity(
                        postEntity: postEntity!,
                      ),
                    ),
                  ),
                )).then((value) {
              if (value != null && value) replyCountIncreased!(true);
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Images.comment
                  .toSvg(width: 12, height: 12, color: Color(0xFF737880)),
              Padding(
                padding: context.isArabic()
                    ? const EdgeInsets.only(bottom: 0, right: 5)
                    : const EdgeInsets.only(bottom: 0, left: 5),
                child: Text(
                  postEntity!.commentCount ?? "",
                  style: const TextStyle(
                      color: Color(0xFF737880),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () => onLikeTap!(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              postEntity!.isLiked == null
                  ? AppIcons.heartIcon(
                color: AppColors.optionIconColor,
              )
                  : postEntity!.isLiked!
                  ? AppIcons.filledHeartIcon()
                  : AppIcons.heartIcon(
                color: AppColors.optionIconColor,
              ),
              Padding(
                padding: context.isArabic()
                    ? const EdgeInsets.only(bottom: 0, right: 5)
                    : const EdgeInsets.only(bottom: 0, left: 5),
                child: Text(
                  postEntity!.likeCount ?? "0",
                  style: TextStyle(
                    color: postEntity!.isLiked == null
                        ? Color(0xFF737880)
                        : postEntity!.isLiked!
                        ? Colors.red
                        : Color(0xFF737880),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        ),
        AppIcons.donationIcon().onTapWidget(() {
          // openDialog(context,postEntity,profileEntity?.id);
          SharedPreferences.getInstance().then((prefs) {
            String? myId = prefs.getString('myKey');
            String? username = prefs.getString('username');
            String? user_id = prefs.getString('user_id');
            debugPrint('username: $username');
            debugPrint('user_id: $user_id');
            String post_id=postEntity!.postId.toString();
            debugPrint('post_id: $post_id');
            donate(context,postEntity!,myId!,user_id,username);
          });
        }),
        InkWell(
          onTap: () {
            onTapRepost!();
            if (!postEntity!.isReposted!) {
              context.showSnackBar(
                message: LocaleKeys.reposted.tr(
                  namedArgs: {'@uname@': 'Post'},
                ),
              );
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Images.repost.toSvg(
                  color: postEntity!.isReposted == null
                      ? Color(0xFF737880)
                      : postEntity!.isReposted!
                      ? AppColors.alertBg
                      : Color(0xFF737880),
                ),
              ),
              Padding(
                padding: context.isArabic()
                    ? const EdgeInsets.only(bottom: 0, right: 5)
                    : const EdgeInsets.only(bottom: 0, left: 5),
                child: Text(
                  postEntity!.repostCount ?? "",
                  style: TextStyle(
                    color: postEntity!.isReposted == null
                        ? Color(0xFF737880)
                        : postEntity!.isReposted!
                        ? AppColors.alertBg
                        : Color(0xFF737880),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        ),
        AppIcons.shareIcon().onTapWidget(
              () async {
            await Share.share(postEntity!.urlForSharing!);
          },
        )
      ]
          .toRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center)
          .toExpanded(),
    ].toRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly);
  }

  // Future openDialog(ctxt,postEntity,meid) => showDialog(
  //     context: ctxt,
  //     builder: (context) => AlertDialog(
  //           title: Text('Donate'),
  //           content: TextField(
  //             decoration: InputDecoration(hintText: 'Amount'),
  //           ),
  //           actions: [
  //             TextButton(onPressed: (){donate(context,postEntity,meid);}, child: Text('Donate',style: TextStyle(color: Color(0xFF2FBF63),),))
  //           ],
  //         ));

  // donate(context,postEntity,meid) {
  //   String? value;
  //
  //   String postId=postEntity.postId.toString();
  //   Navigator.of(context).pop();
  // }
  Future donate(BuildContext context, PostEntity postEntity, String meid, String? user_id, String? username) async {
    String amount = '';
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Donation"),
          content: TextField(
            decoration: InputDecoration(hintText: 'Amount'),
            onChanged: (value) {
              amount = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel',style: TextStyle(color: Color(0xFF2FBF63)),),
            ),
            TextButton(
              onPressed: () async {
                if (amount.isEmpty) {
                  return;
                }
                String wallet = await fetchWallet(user_id, username);
                // check if donation amount is less than or equal to wallet balance
                if (double.parse(amount) > double.parse(wallet)) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Insufficient balance. Please top up your wallet.'),
                  ));
                  Navigator.pop(context);
                  return;
                }
                Map<String, String> data = {
                  "amount": amount,
                  "me_id": meid,
                  "post_id": postEntity.postId.toString()
                };
                var url = Uri.parse('https://shouwt.com/themes/donate_api.php');
                var response = await http.post(url, body: data);

                if (response.statusCode == 200) {
                  // handle success response
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Donation successful!'),
                  ));
                } else {
                  // handle error response
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Failed to donate. Please try again later.'),
                  ));
                }
              },
              child: Text(
                'Donate',
                style: TextStyle(color: Color(0xFF2FBF63)),
              ),
            )
          ],
        ));
  }

  Future<String> fetchWallet(String? userId, String? username) async {
    String url = 'https://shouwt.com/mobile_api/profile?user_id=$userId&username=$username';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // The response is successful and contains data.
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String wallet = jsonResponse['data']['wallet'];
      return wallet;
    } else {
      // The response is unsuccessful.
      print('Error fetching data: ${response.statusCode}');
      return "";
    }
  }

}



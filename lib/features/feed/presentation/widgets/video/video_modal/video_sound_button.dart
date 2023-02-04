import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;
import '../../../bloc/feed_cubit.dart';

class VideoSoundButton extends StatefulWidget {
  const VideoSoundButton(this.controller, {Key? key}) : super(key: key);
  final VideoPlayerController controller;

  @override
  State<VideoSoundButton> createState() => _VideoSoundButtonState();
}

class _VideoSoundButtonState extends State<VideoSoundButton> {
  String muteKey = '';
  bool isMute = true;
  @override
  void initState() {
    super.initState();
    muteKey = getRandomString(25);
  }

  @override
  Widget build(BuildContext context) {
    final _feedCubit = BlocProvider.of<FeedCubit>(context);

    bool isMyButton = muteKey == _feedCubit.muteStringKey;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black45,
      ),
      padding: EdgeInsets.all(3),
      child: GestureDetector(
        onTap: () {
          _feedCubit.changeMuteKey(muteKey);
          checkForMute();
        },
        child: Icon(
          (isMyButton && !isMute) ? Icons.volume_up : Icons.volume_off,
          color: Colors.white70,
          size: 17.sp,
        ),
      ),
    );
  }

  void checkForMute() {
    setState(() {
      isMute = !isMute;
      if (isMute) {
        widget.controller.setVolume(0.0);
      } else {
        widget.controller.setVolume(1.0);
      }
    });
  }

  String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    math.Random _rnd = math.Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );
  }
}

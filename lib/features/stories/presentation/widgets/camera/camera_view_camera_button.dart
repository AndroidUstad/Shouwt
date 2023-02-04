import 'dart:async';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:colibri/core/extensions/context_exrensions.dart';
import '../../../../../core/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CameraViewCameraButton extends StatefulWidget {
  const CameraViewCameraButton(
    this.controller, {
    Key? key,
    required this.onCropped,
  }) : super(key: key);
  final CameraController controller;
  final Function(String) onCropped;

  @override
  State<CameraViewCameraButton> createState() => _CameraViewCameraButtonState();
}

class _CameraViewCameraButtonState extends State<CameraViewCameraButton> {
  bool _isRecording = false;
  double _seconds = 0;
  bool _visible = true;

  void _cameraOnTap() async {
    final xfile = await widget.controller.takePicture();
    final editedImage = await context.editImage(File(xfile.path));

    context.router.push(
      CameraViewConfirmationScreenRoute(
        image: editedImage.newFile.path,
        onCropped: widget.onCropped,
      ),
    );
  }

  void _onLongPress() async {
    await widget.controller.prepareForVideoRecording();
    await widget.controller.startVideoRecording();
    setState(() {
      _isRecording = true;
      _visible = false;
    });
  }

  void _onLongPressEnd() async {
    setState(() {
      _isRecording = false;
      _seconds = 0;
      _visible = true;
    });
    try {
      final xfile = await widget.controller.stopVideoRecording();
      context.router.push(
        CameraViewConfirmationScreenRoute(
          image: xfile.path,
          onCropped: (_) async {
            context.popNTimes(3);
          },
        ),
      );
    } catch (e) {
      return;
    }
  }

  void _updateTimerEverySecond() {
    Timer.periodic(Duration(milliseconds: 100), (_) {
      if (_seconds >= 30) return _onLongPressEnd();
      if (_isRecording) {
        setState(() {
          _seconds += .1;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _updateTimerEverySecond();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: CircularPercentIndicator(
        radius: 30.r,
        lineWidth: 3.0.w,
        percent: _seconds / 30.2,
        animation: true,
        animateFromLastPercent: true,
        progressColor: Colors.red,
        backgroundColor: _isRecording ? Colors.white : Colors.transparent,
        center: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _isRecording ? Colors.transparent : Colors.white,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
            onTap: _cameraOnTap,
            onLongPress: _onLongPress,
            onLongPressEnd: (_) => _onLongPressEnd(),
            child: AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.4,
              duration: const Duration(milliseconds: 100),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isRecording
                        ? Colors.red.shade500
                        : Color.fromRGBO(102, 102, 102, 1),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

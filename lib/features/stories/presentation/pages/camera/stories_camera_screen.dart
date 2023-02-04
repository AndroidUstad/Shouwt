import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:colibri/extensions.dart';
import '../../../../feed/presentation/widgets/link_fetch/default_circular_progress.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/animated_fade_widget.dart';
import '../../../../../core/theme/app_icons.dart';
import '../../widgets/camera/camera_view_camera_button.dart';

class StoriesCameraScreen extends StatefulWidget {
  const StoriesCameraScreen({Key? key}) : super(key: key);

  @override
  State<StoriesCameraScreen> createState() => _StoriesCameraScreenState();
}

class _StoriesCameraScreenState extends State<StoriesCameraScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool isFrontCamera = false;
  int flashIndicator = 0;

  void _initCamera() async {
    _cameras = await availableCameras();
    if (_cameras == null || _cameras!.isEmpty) return;
    _cameraController = CameraController(_cameras![0], ResolutionPreset.max);

    _cameraController!.initialize().whenComplete(() {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  void chnageFlashState() {
    flashIndicator++;
    flashIndicator %= 3;
    final flashMode = flashIndicator == 0
        ? FlashMode.always
        : flashIndicator == 1
            ? FlashMode.auto
            : FlashMode.off;
    _cameraController!.setFlashMode(flashMode);
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  Future<void> swapCamera() async {
    isFrontCamera = !isFrontCamera;
    _cameraController = CameraController(
        _cameras![isFrontCamera ? 1 : 0], ResolutionPreset.max);
    await _cameraController!.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool cameraLoaded = _cameraController?.value.isInitialized ?? false;

    return Scaffold(
      backgroundColor: Colors.black,
      body: !cameraLoaded
          ? DefaultCircularProgress()
          : AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: context.getScreenHeight * .65,
                      width: double.infinity,
                      child: CameraPreview(_cameraController!),
                    ),
                  ),
                  Positioned(
                    top: 40.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: context.getScreenWidth as double,
                      height: context.getScreenHeight as double,
                      margin: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedFadeWidget(
                            onTap: context.router.pop,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              AnimatedFadeWidget(
                                onTap: chnageFlashState,
                                child: Icon(
                                  flashIndicator == 0
                                      ? Icons.flash_on
                                      : flashIndicator == 1
                                          ? Icons.flash_auto
                                          : Icons.flash_off,
                                  color: Colors.white,
                                ),
                              ),
                              10.toSizedBoxHorizontal,
                              AnimatedFadeWidget(
                                onTap: () async => await swapCamera(),
                                child: AppIcons.frontBackSwitchIcon(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: context.getScreenWidth as double,
                    height: context.getScreenHeight as double,
                    margin: EdgeInsets.only(bottom: 40.h),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CameraViewCameraButton(
                        _cameraController!,
                        onCropped: (_) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

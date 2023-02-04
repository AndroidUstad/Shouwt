import 'package:auto_route/auto_route.dart';
import '../../../../core/routes/routes.gr.dart';
import '../splash_color_widget.dart';
import 'package:flutter/material.dart';

class CreateSwiftCameraWidget extends StatelessWidget {
  const CreateSwiftCameraWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        child: Stack(
          children: [
            Container(child: Center(child: Icon(Icons.camera_alt))),
            SplashColorWidget(
              onTap: () => context.router.push(StoriesCameraScreenRoute()),
            ),
          ],
        ),
      );
}

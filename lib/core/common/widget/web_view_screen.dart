import 'package:auto_route/auto_route.dart';
import 'web_view_container.dart';
import '../../extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../extensions/color_extension.dart';
import '../../theme/app_icons.dart';
import '../animated_fade_widget.dart';

class WebViewScreen extends StatefulWidget {
  final String? url;
  final String? name;
  const WebViewScreen({Key? key, this.url, this.name}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final webViewKey = GlobalKey<WebViewContainerState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor.fromHex('#34495e'),
        leading: AnimatedFadeWidget(
          onTap: () => context.router.pop(),
          child: Container(
            transform: Matrix4.translationValues(10, 18, 0),
            child: 'Done'.toSubTitle2(color: Colors.white),
          ),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.0.w),
            child: AnimatedFadeWidget(
              onTap: () => webViewKey.currentState?.reloadWebView(),
              child: AppIcons.refreshIcon(),
            ),
          ),
        ],
        title: _webViewTitle().toHeadLine6(color: Colors.white),
      ),
      body: WebViewContainer(widget.url!, key: webViewKey),
    );
  }

  String _webViewTitle() {
    if (widget.name != null) return widget.name!;
    return widget.url!.hostName;
  }
}

import 'package:flutter/material.dart';

class AnimatedFadeWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final void Function(LongPressEndDetails)? onLongPressEnd;
  const AnimatedFadeWidget({
    Key? key,
    required this.child,
    this.onLongPress,
    this.onTap,
    this.onLongPressEnd,
  }) : super(key: key);

  @override
  _AnimatedFadeWidgetState createState() => _AnimatedFadeWidgetState();
}

class _AnimatedFadeWidgetState extends State<AnimatedFadeWidget> {
  bool _visible = true;
  bool _isLongPress = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.4,
      duration: const Duration(milliseconds: 100),
      onEnd: () {
        if (!_isLongPress) {
          setState(() {
            _visible = true;
          });
        }
      },
      child: GestureDetector(
        onTapDown: (_) => setState(() {
          _visible = false;
        }),
        onTapCancel: () => setState(() {
          _visible = true;
        }),
        onTap: () {
          if (widget.onTap != null) widget.onTap!();
          setState(() {
            _visible = false;
          });
        },
        onLongPress: () {
          if (widget.onLongPress != null) widget.onLongPress!();
          setState(() {
            _visible = false;
            _isLongPress = true;
          });
        },
        onLongPressCancel: () {
          setState(() {
            _visible = true;
            _isLongPress = false;
          });
        },
        onLongPressEnd: (details) {
          if (widget.onLongPressEnd != null) widget.onLongPressEnd!(details);
          setState(() {
            _visible = true;
            _isLongPress = false;
          });
        },
        child: widget.child,
      ),
    );
  }
}

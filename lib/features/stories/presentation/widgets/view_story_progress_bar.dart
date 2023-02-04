import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Create a Circular countdown indicator
class ViewStoryProgressBar extends StatefulWidget {
  /// Timer duration in seconds
  final int duration;

  /// Default Background color
  final Color backgroundColor;

  final Color valueColor;

  /// This call callback will be excuted when the Countdown ends.
  final Function? onComplete;

  /// Stroke width, the default is 10
  final double strokeWidth;
  final double? value;

  /// Initial time, 0 by default
  final int initialPosition;

  /// The style for the remaining time indicator
  /// The default is black color, and fontWeight of W600
  final TextStyle? timeTextStyle;

  /// The formatter for the time string
  /// By default, no formatting is applied and
  /// the time is displayed in number of seconds left
  final String Function(int seconds)? timeFormatter;

  /// The style for the widget label
  /// The default is black color, and fontWeight of W600
  final TextStyle? labelTextStyle;

  /// This text will be shown with the time indicator
  final String? text;

  final AnimationController animationController;

  /// true by default, this value indicates that the timer
  /// will start automatically

  // ignore: public_member_api_docs
  const ViewStoryProgressBar({
    Key? key,
    required this.duration,
    this.initialPosition = 0,
    required this.backgroundColor,
    required this.valueColor,
    required this.animationController,
    this.onComplete,
    this.timeTextStyle,
    this.timeFormatter,
    this.labelTextStyle,
    this.strokeWidth = 10,
    this.text,
    this.value,
  })  : assert(duration > 0),
        assert(initialPosition < duration),
        super(key: key);

  @override
  _ViewStoryProgressBarState createState() => _ViewStoryProgressBarState();
}

class _ViewStoryProgressBarState extends State<ViewStoryProgressBar>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animation = Tween<double>(
      begin: widget.initialPosition.toDouble(),
      end: widget.duration.toDouble(),
    ).animate(widget.animationController);

    widget.animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 4.h,
        child: LinearProgressIndicator(
          backgroundColor: widget.backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(widget.valueColor),
          value: widget.value ?? _animation.value / widget.duration,
        ),
      ),
    );
  }
}

// /// Helper class for CountDown widget
// class CountDownController {
//   late _ViewStoryProgressBarState _state;

//   /// Pause countdown timer
//   void pause() {
//     _state._animationController.stop(canceled: false);
//   }

//   /// Resumes countdown time
//   void resume() {
//     _state._animationController.forward();
//   }

//   /// Starts countdown timer
//   /// This method works when [autostart] is false
//   void start() {
//     _state._animationController
//         .forward(from: _state.widget.initialPosition.toDouble());
//   }

//   /// Restarts countdown timer.
//   ///
//   /// * [duration] is an optional value, if this value is null,
//   /// the duration will use the previous one defined in the widget
//   /// * Use [initialPosition] if you want the original position
//   void restart({int? duration, required double initialPosition}) {
//     if (duration != null) {
//       _state._animationController.duration = Duration(seconds: duration);
//     }

//     _state._animationController.forward(from: initialPosition);
//   }
// }

import 'package:flutter/material.dart';

class SplashColorWidget extends StatelessWidget {
  final VoidCallback onTap;
  const SplashColorWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(onTap: onTap, splashColor: Colors.black12),
    );
  }
}

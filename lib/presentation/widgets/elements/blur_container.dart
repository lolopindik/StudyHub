import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {
  final Widget child;
  final Color blurColor;

  const BlurContainer({
    super.key,
    required this.child,
    this.blurColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('lib/assets/images/background.png'),
          fit: BoxFit.cover,
        ),
        color: blurColor,
      ),
      child: child,
    );
  }
} 
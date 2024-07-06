// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoTransparentIndicator extends StatelessWidget {
  const CupertinoTransparentIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: const Center(
        child: CupertinoActivityIndicator(radius: 20.0, color: Colors.white70,)
        ),
      );
  }
}

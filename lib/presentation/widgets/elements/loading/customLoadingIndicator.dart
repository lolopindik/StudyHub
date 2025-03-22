// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomTransparentLoadingIndicator extends StatelessWidget {
  const CustomTransparentLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white70, 
        ),
      ),
    );
  }
}
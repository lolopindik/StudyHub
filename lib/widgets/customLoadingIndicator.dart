// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.mainColor, 
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white70, 
        ),
      ),
    );
  }
}

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
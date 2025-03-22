// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:study_hub/logic/config/theme/app_theme.dart';

class CustomMainColorLoadingIndicator extends StatelessWidget {
  const CustomMainColorLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.mainElementColor,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white70, 
        ),
      ),
    );
  }
}
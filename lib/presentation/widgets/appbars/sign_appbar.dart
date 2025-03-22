import 'package:flutter/material.dart';
import 'package:study_hub/logic/config/theme/app_theme.dart';

  PreferredSizeWidget? buildSignAppBar(BuildContext context) {
    return AppBar(
      //отключение автоматического arrow back
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: AppTheme.mainColor,
      title: const Text(
        'StudyHub',
        style: TextStyles.ruberoidRegular28,
      ),
      centerTitle: true,
    );
  }
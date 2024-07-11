import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';

  PreferredSizeWidget? buildWebViewAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: AppTheme.mainColor,
      title: const Text(
        'Testing WebView',
        style: TextStyles.ruberoidRegular28,
      ),
      centerTitle: true,
      leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.secondaryColor,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 23,
                color: Colors.grey,
              ),
            ),
          ),
        )
    );
  }
import 'package:flutter/material.dart';
import 'package:study_hub/logic/config/theme/app_theme.dart';

  PreferredSizeWidget? buildWebViewAppBar(BuildContext context, String title) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: AppTheme.mainColor,
      title: Text(
        title,
        style: TextStyles.ruberoidLight16,
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
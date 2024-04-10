import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';

  PreferredSizeWidget? buildHomeAppBar(BuildContext context) {
    return AppBar(
      //отключение автоматического arrow back
      automaticallyImplyLeading: false,
      backgroundColor: AppTheme.mainColor,
      title: const Text(
        'StudyHub',
        style: TextStyles.ruberoidRegular28,
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.secondaryColor,
            ),
            child: IconButton(
              onPressed: () {
                // переход к page-настройки 
              },
              icon: const Icon(
                Icons.tune,
                size: 23,
                color: Colors.grey,
              ),
            ),
          ),
        )
      ],
    );
  }
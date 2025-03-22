import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';

PreferredSizeWidget? buildSettingsAppBar(BuildContext context, String title) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    automaticallyImplyLeading: false,
    title: Text(
      title,
      style: TextStyles.ruberoidRegular28,
    ),
    centerTitle: true,
    backgroundColor: AppTheme.mainColor,
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
            Navigator.pop(context, true);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 23,
            color: Colors.grey,
          ),
        ),
      ),
    ),
  );
}

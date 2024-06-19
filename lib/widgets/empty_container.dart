import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';

Widget buildEmptyContaine(String text, BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: AppTheme.mainColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              text,
              style: TextStyles.ruberoidLight20,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
      ),
    );
  }
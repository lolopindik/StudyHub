import 'dart:io';

import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/elements/details/webview_dialog.dart';

Widget buildUrl(BuildContext context, String url) {
  return GestureDetector(
    onTap: () {
      debugPrint('link pushed');
      if (Platform.isAndroid) {
        showWebviewDialog(context, url);
      }
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: AppTheme.mainElementColor,
      ),
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      height: MediaQuery.of(context).size.height * 0.08,
      constraints: const BoxConstraints(minHeight: 60),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              const Icon(
                Icons.link,
                color: Colors.white54,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  url,
                  style: TextStyles.ruberoidLight16,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

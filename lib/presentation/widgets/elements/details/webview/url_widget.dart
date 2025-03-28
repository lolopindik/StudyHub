import 'package:flutter/material.dart';
import 'package:study_hub/logic/config/theme/app_theme.dart';
import 'package:study_hub/presentation/widgets/elements/details/webview/webview_dialog.dart';

Widget buildUrl(BuildContext context, String url, VoidCallback sendingReply) {
  return GestureDetector(
    onTap: () {
      debugPrint('link pushed');
      showWebviewDialog(context, url, sendingReply);
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

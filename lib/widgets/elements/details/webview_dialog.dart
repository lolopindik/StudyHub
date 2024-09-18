import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/elements/details/open_webview.dart';

Future<void> showWebviewDialog(BuildContext context, String url, VoidCallback sendingReply) async {
  if (Platform.isAndroid) {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.mainColor,
          surfaceTintColor: Colors.transparent,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  url,
                  textAlign: TextAlign.center,
                  style: TextStyles.ruberoidLight16,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text('Нет', style: TextStyles.ruberoidRegular20),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Да',
                    style: TextStyles.ruberoidLight16,
                  ),
                  onPressed: () {
                    debugPrint('url confirmed');
                    Navigator.pop(context);
                    openWebView(context, url);
                    sendingReply();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
  if (Platform.isIOS) {
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: Text(
          url,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            isDefaultAction: true,
            child: const Text(
              'Нет',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              debugPrint('url confirmed');
              Navigator.pop(context);
              openWebView(context, url);
              sendingReply();
            },
            child: const Text(
              'Да',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

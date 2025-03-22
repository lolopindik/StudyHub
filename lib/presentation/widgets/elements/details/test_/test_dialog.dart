import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';

Future<void> showTestDialog(context, VoidCallback removeSelectedAnswerToFirebase) async {
  if (Platform.isAndroid) {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.mainColor,
          surfaceTintColor: Colors.transparent,
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'Хотите отправить ответ заново?',
                  textAlign: TextAlign.center,
                  style: TextStyles.ruberoidLight18,
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
                    removeSelectedAnswerToFirebase();
                    debugPrint('reply resent');
                    Navigator.of(context).pop();
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
        content: const Text(
          'Хотитк отправить запрос заново?',
          style: TextStyle(fontSize: 16),
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
              removeSelectedAnswerToFirebase();
              debugPrint('reply resent');
              Navigator.of(context).pop();
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
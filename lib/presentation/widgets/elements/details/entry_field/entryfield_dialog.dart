import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/logic/config/theme/app_theme.dart';

Future<void> showEntryFieldCorrectDialog(
    BuildContext context, String text, Function submitAnswer) async {
  if (Platform.isAndroid) {
    await showDialog<void>(
      barrierDismissible: false,
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
                  text,
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
                    for (var i = 0; i < 2; i++) {
                      Navigator.pop(context);
                    }
                  },
                ),
                TextButton(
                  child: const Text(
                    'Да',
                    style: TextStyles.ruberoidLight16,
                  ),
                  onPressed: () {
                    submitAnswer();
                    for (var i = 0; i < 2; i++) {
                      Navigator.pop(context);
                    }
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
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: Text(
          text,
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
              submitAnswer();
              for (var i = 0; i < 2; i++) {
                Navigator.pop(context);
              }
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

Future<void> showEntryFieldInCorrectDialog(
    BuildContext context, String text) async {
  if (Platform.isAndroid) {
    await showDialog<void>(
      barrierDismissible: false,
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
                  text,
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
                  child: const Text('ОК', style: TextStyles.ruberoidLight16),
                  onPressed: () {
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
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'ОК',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

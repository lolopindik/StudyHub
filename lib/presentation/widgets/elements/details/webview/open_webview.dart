import 'package:flutter/material.dart';
import 'package:study_hub/presentation/pages/lessons/webview_page.dart';

Future<void> openWebView(BuildContext context, String url) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebviewPage(
          link: url,
        ),
      ),
    );
  }
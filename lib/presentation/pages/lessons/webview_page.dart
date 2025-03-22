import 'package:flutter/material.dart';
import 'package:study_hub/widgets/appbars/webview_appbar.dart';
import 'package:study_hub/widgets/bottombars/webview_bottombar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  final String link;
  const WebviewPage({super.key, required this.link});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late String url;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    url = widget.link;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildWebViewAppBar(context, url),
      bottomNavigationBar: buildWebViewBottomBar(context, controller),
      body: WebViewWidget(controller: controller),
    );
  }
}
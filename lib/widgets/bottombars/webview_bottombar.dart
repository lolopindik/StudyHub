import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

BottomAppBar buildWebViewBottomBar(BuildContext context, WebViewController controller) {
  return BottomAppBar(
    height: MediaQuery.of(context).size.height * 0.09,
    color: AppTheme.mainColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 120,
          margin: const EdgeInsets.only(left: 20),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
                onPressed: () async {
                  if (await controller.canGoBack()) {
                    controller.goBack();
                  }
                  showMessage(context, true);
                },
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white70, size: 25)),
            IconButton(
                onPressed: () async {
                  if (await controller.canGoForward()) {
                    controller.goForward();
                  }
                  showMessage(context, false);
                },
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 25)),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 40),
          child: IconButton(
            onPressed: () {
              controller.reload();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white70,
              size: 30,
            ),
          ),
        ),
      ],
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showMessage(
    BuildContext context, bool isBack) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        isBack ? 'Назад' : 'Далее',
        style: TextStyles.ruberoidLight16
      ),
      duration: const Duration(seconds: 1),
    ),
  );
}

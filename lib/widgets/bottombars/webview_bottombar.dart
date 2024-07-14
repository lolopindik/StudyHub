import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';

BottomAppBar buildWebViewBottomBar(BuildContext context) {
  return BottomAppBar(
    color: AppTheme.mainColor,
    height: MediaQuery.of(context).size.height * 0.08,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 120,
          margin: const EdgeInsets.only(left: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
                onPressed: () {
                  showMessage(context, true);
                },
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white70)),
            IconButton(
                onPressed: () {
                  showMessage(context, false);
                },
                icon:
                    const Icon(Icons.arrow_forward_ios, color: Colors.white70)),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 40),
          child: IconButton(
            onPressed: () {},
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
    BuildContext context, bool position) {
  return (position)
      ? ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Назад', style: TextStyles.ruberoidLight16),
            duration: Duration.zero,
          ),
        )
      : ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Далее', style: TextStyles.ruberoidLight16),
            duration: Duration.zero,
          ),
        );
}

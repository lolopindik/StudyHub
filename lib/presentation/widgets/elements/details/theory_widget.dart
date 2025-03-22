import 'package:flutter/material.dart';
import 'package:study_hub/logic/config/theme/app_theme.dart';

Widget buildTheory(BuildContext context, String theory) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 15, right: 10),
    child: Text(
      textAlign: TextAlign.start,
      theory,
      style: TextStyles.ruberoidLight18,
    ),
  );
}

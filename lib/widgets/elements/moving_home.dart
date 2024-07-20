//At home, why don't I feel at home, that I... at home...

import 'package:flutter/material.dart';
import 'package:study_hub/pages/home/home_page.dart';
import 'package:study_hub/preferences/app_theme.dart';

Widget buildHomeTextBotton(BuildContext context, String title) {
  return TextButton(onPressed: () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
      },child: Text(title, style: TextStyles.ruberoidRegular28,),);
}
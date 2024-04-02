// ignore: file_names
import 'package:flutter/material.dart';
//import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/sign_widgets.dart';

class SignUpIn extends StatelessWidget {
  const SignUpIn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildSignAppBar(context),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('lib/assets/images/background.png'),
                fit: BoxFit.cover,
              )),
            ),
            buildSignBottomBar(context)
          ],
        ));
  }
}

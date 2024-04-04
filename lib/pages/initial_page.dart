import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_hub/pages/sign_up_In.dart';
import 'package:study_hub/pages/welcome_page.dart';


class InitialPage  extends StatelessWidget {
  const InitialPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isFirstTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        //* вывод welcome page при первом запуске
        if (snapshot.hasData && snapshot.data == true) {
          _setFirstTime(false); 
          return const WelcomePage();
        }
        return const SignUpInPage();
      },
    );
  }

  Future<bool> _isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_time') ?? true;
  }

  void _setFirstTime(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first_time', value);
  }
}
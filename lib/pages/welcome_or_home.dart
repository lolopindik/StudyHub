import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_hub/pages/reg_or_auth_page.dart';
import 'package:study_hub/pages/welcome_page.dart';


class WelcomeOrSignUpIn extends StatelessWidget {
  const WelcomeOrSignUpIn({super.key});

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
        if (snapshot.hasData && snapshot.data == true) {
          _setFirstTime(false); // Устанавливаем значение в false
          return const WelcomePage();
        }
        return const SignUpIn();
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
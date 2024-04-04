import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_hub/pages/sign_up_In.dart';
import 'package:study_hub/pages/welcome_page.dart';
import 'package:study_hub/pages/home_page.dart';
import 'package:study_hub/preferences/app_theme.dart'; // Импорт HomePage

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isFirstTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppTheme.secondaryColor,
                backgroundColor: AppTheme.mainColor,
              ),
            ),
          );
        }

        // Проверяем, аутентифицирован ли пользователь
        if (snapshot.hasData && snapshot.data == false) {
          return const HomePage(); // Если пользователь аутентифицирован, переходим на HomePage
        }

        // Пользователь не аутентифицирован, продолжаем с WelcomePage или SignUpInPage
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
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    return isLoggedIn ?? true; // Если значение null, считаем, что пользователь не аутентифицирован
  }

  void _setFirstTime(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }
}
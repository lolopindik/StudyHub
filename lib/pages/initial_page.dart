import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Импорт Firebase Authentication
import 'package:study_hub/pages/sign_up_In.dart';
import 'package:study_hub/pages/welcome_page.dart';
import 'package:study_hub/pages/home_page.dart';
import 'package:study_hub/preferences/app_theme.dart'; // Импорт HomePage

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _getCurrentUser(),
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
        if (snapshot.hasData && snapshot.data != null) {
          return const HomePage(); // Если пользователь аутентифицирован, переходим на HomePage
        }

        // Проверяем, если это новый пользователь, направляем на WelcomePage
        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const WelcomePage();
        }

        // Пользователь не аутентифицирован, продолжаем с SignUpInPage
        return const SignUpInPage();
      },
    );
  }

  Future<User?> _getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.currentUser;
  }
}

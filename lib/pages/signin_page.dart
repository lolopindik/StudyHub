// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_hub/pages/home_page.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/auth.dart';
import 'package:email_validator/email_validator.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> saveUserSession(String userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
  
}

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      pageTitle: 'Авторизация',
      emailController: emailController,
      passwordController: passwordController,
      onConfirmPressed: () async {
        String email = emailController.text.trim();
        String password = passwordController.text.trim();

        if (!EmailValidator.validate(email)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Неверный формат электронной почты', style: TextStyles.ruberoidLight16),
            ),
          );
          return;
        }

        try {
          UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          // Получаем данные о вошедшем пользователе
          User? user = userCredential.user;
          
          // Пример использования данных пользователя
          print('Пользователь успешно вошел в систему: ${user?.uid}');

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Аутентификация успешна', style: TextStyles.ruberoidLight16),
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
          // Аутентификация успешна, можно выполнить дополнительные действия, например, переход на другой экран
        } catch (e) {
          // Обработка ошибки аутентификации, например, вывод сообщения об ошибке
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Ошибка аутентификации: $e', style: TextStyles.ruberoidLight16,),
            ),
          );
        }
      },
    );
  }
}

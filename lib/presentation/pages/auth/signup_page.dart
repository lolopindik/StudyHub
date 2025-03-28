// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_hub/presentation/pages/auth/verify_page.dart';
import 'package:study_hub/logic/config/theme/app_theme.dart';
import 'package:study_hub/presentation/widgets/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> saveUserSession(String userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
}

  @override
  Widget build(context) {
    return AuthPage(
      pageTitle: 'Регистрация',
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

        // Проверка текущей сессии пользователя
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Пользователь уже аутентифицирован', style: TextStyles.ruberoidLight16),
            ),
          );
          // Выполните необходимые действия, если пользователь уже аутентифицирован
          return;
        }

        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          // Получаем данные о зарегистрированном пользователе
          User? user = userCredential.user;

          // Пример использования данных пользователя
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Данные переданы присвоен ID: ${user?.uid}', style: TextStyles.ruberoidLight16),
            ),
          );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VerifyPage()),
            
          );

        } catch (e) {
          // Обработка ошибки регистрации, например, вывод сообщения об ошибке
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Ошибка при регистрации: $e', style: TextStyles.ruberoidLight16),
            ),
          );
        }
      },
    );
  }
}

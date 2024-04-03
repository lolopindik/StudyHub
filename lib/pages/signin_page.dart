import 'package:flutter/material.dart';
import 'package:study_hub/types/auth.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      pageTitle: 'Авторизация',
      emailController: emailController,
      passwordController: passwordController,
      onConfirmPressed: () {
        //TODO_Действие при нажатии на кнопку "Подтвердить" на странице регистрации
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:study_hub/types/auth.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      pageTitle: 'Регистрация',
      emailController: emailController,
      passwordController: passwordController,
      onConfirmPressed: () {
        //TODO_Действие при нажатии на кнопку "Подтвердить" на странице регистрации
      },
    );
  }
}

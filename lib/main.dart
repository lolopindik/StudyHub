import 'package:flutter/material.dart';
import 'package:study_hub/pages/welcome_or_home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeOrSignUpIn(),
    );
  }
}

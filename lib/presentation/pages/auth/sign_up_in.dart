// ignore: file_names
import 'package:flutter/material.dart';
import 'package:study_hub/presentation/pages/auth/password_reset_page.dart';
import 'package:study_hub/presentation/pages/auth/signin_page.dart';
import 'package:study_hub/presentation/pages/auth/signup_page.dart';
import 'package:study_hub/logic/config/theme/app_theme.dart';
import 'package:study_hub/presentation/widgets/appbars/sign_appbar.dart';

class SignUpInPage extends StatefulWidget {
  const SignUpInPage({super.key});

  @override
  SignUpInPageState createState() => SignUpInPageState();
}

class SignUpInPageState extends State<SignUpInPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mainColor,
      appBar: buildSignAppBar(context),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          buildSignBottomBar(context),
          Positioned.fill(
            child: IndexedStack(
              index: _selectedIndex,
              children: <Widget>[
                SignUpPage(),
                SignInPage(),
              ],
            ),
          ),
          Positioned(
              bottom: 120,
              right: 40,
              left: 40,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PasswordResetPage(),
                    ),
                  );
                },
                child: const Text(
                  'Восстановить пароль?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget buildSignBottomBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 210,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: AppTheme.mainColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  icon: const Icon(Icons.person_add_alt, size: 45),
                  color: _selectedIndex == 0 ? Colors.white : Colors.grey,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  icon: const Icon(Icons.person_outline_outlined, size: 45),
                  color: _selectedIndex == 1 ? Colors.white : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

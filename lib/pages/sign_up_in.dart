// ignore: file_names
import 'package:flutter/material.dart';
import 'package:study_hub/pages/signin_page.dart';
import 'package:study_hub/pages/signup_page.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/sign_widgets.dart';

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

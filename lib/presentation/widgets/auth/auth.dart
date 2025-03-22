import 'package:flutter/material.dart';
import 'package:study_hub/logic/config/theme/app_theme.dart';

class AuthPage extends StatelessWidget {
  final String pageTitle;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onConfirmPressed;

  const AuthPage({
    super.key,
    required this.pageTitle,
    required this.emailController,
    required this.passwordController,
    required this.onConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 340,
            width: 319,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppTheme.secondaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    pageTitle,
                    style: TextStyles.ruberoidLight32,
                  ),
                ),
                Container(
                  height: 264,
                  width: 319,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppTheme.mainColor,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          width: 282,
                          height: 51,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: AppTheme.signElementColor,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: TextField(
                                controller: emailController,
                                style: TextStyles.ruberoidLight16,
                                decoration: const InputDecoration(
                                  hintText: 'Email:',
                                  hintStyle: TextStyles.ruberoidLight20,
                                  border: InputBorder.none,
                                ),
                                cursorColor: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: 282,
                          height: 51,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: AppTheme.signElementColor,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: TextField(
                                obscureText: true,
                                controller: passwordController,
                                style: TextStyles.ruberoidLight16,
                                decoration: const InputDecoration(
                                  hintText: 'Password:',
                                  hintStyle: TextStyles.ruberoidLight20,
                                  border: InputBorder.none,
                                ),
                                cursorColor: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 61),
                        child: InkWell(
                          onTap: onConfirmPressed,
                          child: Container(
                            width: 282,
                            height: 51,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: AppTheme.secondaryColor,
                            ),
                            child: const Center(
                              child: Text(
                                'Подтвердить',
                                style: TextStyles.ruberoidLight20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

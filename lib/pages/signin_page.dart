import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 120),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 340,
          width: 319,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppTheme.secondaryColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Авторизация',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

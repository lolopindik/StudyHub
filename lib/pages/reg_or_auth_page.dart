import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';


class SignUpIn extends StatelessWidget {
  const SignUpIn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/background.png'),
            fit: BoxFit.cover,
          )
        ),
        child: const Center(child: Text('TEST', style: TextStyles.ruberoidRegular40,),),
      ),
    );
  }
}

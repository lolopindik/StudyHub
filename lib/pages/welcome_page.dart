import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_hub/pages/sign_up_in.dart';
import 'package:study_hub/preferences/app_theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          // Проверяем направление свайпа
          if (details.primaryVelocity! < 0) {
            // Переходим на SignUpIn страницу
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const SignUpInPage(),
              ),
            );
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      Text(
                        'Добро Пожаловать',
                        style: TextStyles.ruberoidLight28
                      ),
                      Text(
                        'StudyHub',
                        style: TextStyles.ruberoidRegular40
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50, left: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Продолжить',
                            style: TextStyles.ruberoidLight32
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset(
                            'lib/assets/images/svg/arrow1_wellcomepage.svg',
                          ),
                          SvgPicture.asset(
                            'lib/assets/images/svg/arrow2_wellcomepage.svg',
                          ),
                          SvgPicture.asset(
                            'lib/assets/images/svg/arrow3_wellcomepage.svg',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
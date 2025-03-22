import 'package:flutter/material.dart';
import 'package:study_hub/logic/config/theme/app_theme.dart';
import 'package:study_hub/presentation/widgets/appbars/sign_appbar.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSignAppBar(context),
      backgroundColor: AppTheme.secondaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                color: AppTheme.mainColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Нет подключения',
                      style: TextStyles.ruberoidRegular28,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/settings_appbar.dart';

class UserSettings extends StatelessWidget {
  const UserSettings(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSettingsAppBar(context),
      backgroundColor: AppTheme.secondaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Основные',
                      style: TextStyles.ruberoidLight28,
                    ),
                    SizedBox(
                      width: 156,
                      height: 4,
                      child: Container(
                        color: AppTheme.mainColor,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: AppTheme.mainElementColor
                      ),
                      constraints:const BoxConstraints(maxWidth: 450, minHeight: 40),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: AppTheme.mainElementColor
                      ),
                      constraints:const BoxConstraints(maxWidth: 450, minHeight: 40),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: AppTheme.mainElementColor
                      ),
                      constraints:const BoxConstraints(maxWidth: 450, minHeight: 40),
                    ),
                    const SizedBox(height: 20,),
                    const Text(
                      'Дополнительные',
                      style: TextStyles.ruberoidLight28,
                    ),
                    SizedBox(
                      width: 265,
                      height: 4,
                      child: Container(
                        color: AppTheme.mainColor,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: AppTheme.mainElementColor
                      ),
                      constraints:const BoxConstraints(maxWidth: 450, minHeight: 40),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: AppTheme.mainElementColor
                      ),
                      constraints: const BoxConstraints(maxWidth: 450, minHeight: 40),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: AppTheme.mainElementColor
                      ),
                      constraints:const BoxConstraints(maxWidth: 450, minHeight: 40),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
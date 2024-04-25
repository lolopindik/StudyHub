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
                      width: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: AppTheme.mainElementColor
                      ),
                      constraints:const BoxConstraints(maxWidth: 450, minHeight: 40),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Icon(Icons.person, size: 30, color: Colors.white54,),
                            SizedBox(width: 20,),
                            Text('Аккаунт', style: TextStyles.ruberoidLight20,)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: AppTheme.mainElementColor
                      ),
                      constraints:const BoxConstraints(maxWidth: 450, minHeight: 40),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Icon(Icons.logout, size: 30, color: Colors.white54,),
                            SizedBox(width: 20,),
                            Text('Выход', style: TextStyles.ruberoidLight20,)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: AppTheme.mainElementColor
                      ),
                      constraints:const BoxConstraints(maxWidth: 450, minHeight: 40),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Icon(Icons.delete_forever_outlined, size: 30, color: Colors.white54,),
                            SizedBox(width: 20,),
                            Text('Удаление Аккаунта', style: TextStyles.ruberoidLight20,)
                          ],
                        ),
                      ),
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
                      width: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: AppTheme.mainElementColor
                      ),
                      constraints:const BoxConstraints(maxWidth: 450, minHeight: 40),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Icon(Icons.code, size: 30, color: Colors.white54,),
                            SizedBox(width: 20,),
                            Text('О программе', style: TextStyles.ruberoidLight20,)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: AppTheme.mainElementColor
                      ),
                      constraints:const BoxConstraints(maxWidth: 450, minHeight: 40),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Icon(Icons.bug_report_outlined, size: 30, color: Colors.white54,),
                            SizedBox(width: 20,),
                            Text('Сообщить об ошибке', style: TextStyles.ruberoidLight20,)
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
      ),
    );
  }
}
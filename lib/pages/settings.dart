// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/fire_funcs.dart';
import 'package:study_hub/pages/sign_up_in.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/settings_appbar.dart';

class UserSettings extends StatefulWidget {
  const UserSettings(BuildContext context, {super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  String? _userId;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
    }
  }

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
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Account');
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: AppTheme.mainElementColor),
                        constraints:
                            const BoxConstraints(maxWidth: 600, minHeight: 40),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.white54,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Аккаунт',
                                style: TextStyles.ruberoidLight20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //!
                    GestureDetector(
                      onTap: () async {
                        bool confirmLogout = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: AppTheme.mainColor,
                              surfaceTintColor: Colors.transparent,
                              title: const Text(
                                'Подтвердите выход',
                                style: TextStyles.ruberoidRegular20,
                              ),
                              content: const Text(
                                'Вы уверены, что хотите выйти из аккаунта?',
                                style: TextStyles.ruberoidLight16,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text(
                                    'Отмена',
                                    style: TextStyles.ruberoidLight16,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text(
                                    'Выйти',
                                    style: TextStyles.ruberoidLight16,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                        if (confirmLogout == true) {
                          print('Exit from account');
                          await FirebaseService().logOut();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Вы успешно вышли из аккаунта'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpInPage()),
                          );
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: AppTheme.mainElementColor),
                        constraints:
                            const BoxConstraints(maxWidth: 600, minHeight: 40),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                size: 30,
                                color: Colors.white54,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Выход',
                                style: TextStyles.ruberoidLight20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //!
                    GestureDetector(
                      onTap: () async {
                        bool confirmDelete = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: AppTheme.mainColor,
                              surfaceTintColor: Colors.transparent,
                              title: const Text(
                                'Подтвердите удаление аккаунта',
                                style: TextStyles.ruberoidRegular20,
                              ),
                              content: const Text(
                                'Вы уверены, что хотите удалить аккаунт? Это действие нельзя отменить и приведет к потере всех данных.',
                                style: TextStyles.ruberoidLight16,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text(
                                    'Отмена',
                                    style: TextStyles.ruberoidLight16,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text(
                                    'Удалить',
                                    style: TextStyles.ruberoidLight16,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                        if (confirmDelete == true) {
                          print('Deleting account...');
                          try {
                            // Вызов функции удаления аккаунта из Firebase
                            await FirebaseService().deleteAcc(_userId!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Аккаунт успешно удален'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            // После удаления аккаунта перенаправляем пользователя на страницу входа/регистрации
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpInPage()),
                            );
                          } catch (error) {
                            print("Ошибка при удалении аккаунта: $error");
                          }
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: AppTheme.mainElementColor),
                        constraints:
                            const BoxConstraints(maxWidth: 600, minHeight: 40),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_forever_outlined,
                                size: 30,
                                color: Colors.white54,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Удалить аккаунт',
                                style: TextStyles.ruberoidLight20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
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
                    const SizedBox(
                      height: 20,
                    ),

                    //!
                    GestureDetector(
                      onTap: () {
                        print('About program');
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: AppTheme.mainElementColor),
                        constraints:
                            const BoxConstraints(maxWidth: 600, minHeight: 40),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.code,
                                size: 30,
                                color: Colors.white54,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'О программе',
                                style: TextStyles.ruberoidLight20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //!
                    GestureDetector(
                      onTap: () {
                        print('Message to support');
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: AppTheme.mainElementColor),
                        constraints:
                            const BoxConstraints(maxWidth: 600, minHeight: 40),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.bug_report_outlined,
                                size: 30,
                                color: Colors.white54,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Сообщить об ошибке',
                                style: TextStyles.ruberoidLight20,
                              )
                            ],
                          ),
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

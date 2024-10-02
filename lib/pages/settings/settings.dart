// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_hub/backend/fire_funcs.dart';
import 'package:study_hub/pages/settings/app_info_page.dart';
import 'package:study_hub/pages/user/account_info.dart';
import 'package:study_hub/pages/auth/sign_up_in.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/appbars/settings_appbar.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

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


  Future<void> rotateToAppInfo() async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AppInfoPage()));
  }

  Future<void> _showAccountInfoDialog() async {
    if (Platform.isIOS) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 148, 148, 148),
            surfaceTintColor: Colors.transparent,
            content: const AccountInfo(),
            actions: <Widget>[
              Center(
                child: Container(
                  width: 76,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 179, 173, 173),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 23,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else if (Platform.isAndroid) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppTheme.mainColor,
            surfaceTintColor: Colors.transparent,
            content: const AccountInfo(),
            actions: <Widget>[
              Center(
                child: Container(
                  width: 76,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: AppTheme.secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 23,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _confirmAction({
    required String title,
    required String content,
    required Function onConfirm,
  }) async {
    bool? confirm;
    if (Platform.isIOS) {
      confirm = await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content, style: const TextStyle(fontSize: 16)),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'Отмена',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              isDefaultAction: true,
              child: const Text(
                'Подтвердить',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      );
    } else if (Platform.isAndroid) {
      confirm = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppTheme.mainColor,
            surfaceTintColor: Colors.transparent,
            title: Text(
              title,
              style: TextStyles.ruberoidRegular20,
            ),
            content: Text(
              content,
              style: TextStyles.ruberoidLight16,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text(
                      'Отмена',
                      style: TextStyles.ruberoidLight15,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text(
                      'Подтвердить',
                      style: TextStyles.ruberoidLight15,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    if (confirm == true) {
      await onConfirm();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> settings = [
      {
        'icon': Icons.person,
        'label': 'Аккаунт',
        'onTap': () => _showAccountInfoDialog(),
      },
      {
        'icon': Icons.logout,
        'label': 'Выход',
        'onTap': () async {
          await _confirmAction(
            title: 'Подтвердите выход',
            content: 'Вы уверены, что хотите выйти из аккаунта?',
            onConfirm: () async {
              await FirebaseService().logOut();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Вы успешно вышли из аккаунта',
                    style: TextStyles.ruberoidLight16,
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpInPage(),
                ),
              );
            },
          );
        },
      },
      {
        'icon': Icons.delete_forever_outlined,
        'label': 'Удалить аккаунт',
        'onTap': () async {
          await _confirmAction(
            title: 'Подтвердите удаление аккаунта',
            content: 'Вы уверены, что хотите удалить аккаунт?',
            onConfirm: () async {
              try {
                await FirebaseService().deleteAcc(_userId!);
                await FirebaseService().deleteProgress(_userId);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Аккаунт успешно удален',
                      style: TextStyles.ruberoidLight16,
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpInPage(),
                  ),
                );
              } catch (error) {
                debugPrint("Ошибка при удалении аккаунта: $error");
              }
            },
          );
        },
      },
      {
        'icon': Icons.code,
        'label': 'О программе',
        'onTap': () => rotateToAppInfo(),
      },
      // {
      //   'icon': Icons.bug_report_outlined,
      //   'label': 'Сообщить об ошибке',
      //   'onTap': () => debugPrint('Message to support'),
      // },
    ];

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        appBar: buildSettingsAppBar(context, 'Настройки'),
        backgroundColor: AppTheme.secondaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            itemCount: settings.length + 2, // 2 extra for headers
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              } else if (index == 4) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const SizedBox(height: 20),
                  ],
                );
              } else {
                final setting = settings[index > 3 ? index - 2 : index - 1];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: () => setting['onTap'](),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: AppTheme.mainElementColor,
                      ),
                      constraints: const BoxConstraints(maxWidth: 600, minHeight: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 10),
                            child: Icon(
                              setting['icon'],
                              color: Colors.grey,
                              size: 34,
                            ),
                          ),
                          Text(
                            setting['label'],
                            style: TextStyles.ruberoidRegular20,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
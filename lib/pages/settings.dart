// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/fire_funcs.dart';
import 'package:study_hub/pages/account_info.dart';
import 'package:study_hub/pages/sign_up_in.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/settings_appbar.dart';

class UserSettings extends StatefulWidget {
  const UserSettings(
    BuildContext context, {
    super.key,
  });

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

  Widget _buildSettingItem({
    required IconData icon,
    required String label,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: AppTheme.mainElementColor,
        ),
        constraints: const BoxConstraints(maxWidth: 600, minHeight: 40),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.white54,
              ),
              const SizedBox(width: 20),
              Text(
                label,
                style: TextStyles.ruberoidLight20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAccountInfoDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.mainColor,
          surfaceTintColor: Colors.transparent,
          content: const AccountInfo(),
          actions: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.secondaryColor,
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

  Future<void> _confirmAction({
    required String title,
    required String content,
    required Function onConfirm,
  }) async {
    bool confirm = await showDialog(
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
                'Подтвердить',
                style: TextStyles.ruberoidLight16,
              ),
            ),
          ],
        );
      },
    );
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
            content:
                'Вы уверены, что хотите удалить аккаунт? Это действие нельзя отменить и приведет к потере всех данных.',
            onConfirm: () async {
              try {
                await FirebaseService().deleteAcc(_userId!);
                await FirebaseService().logOut();
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
                print("Ошибка при удалении аккаунта: $error");
              }
            },
          );
        },
      },
      {
        'icon': Icons.code,
        'label': 'О программе',
        'onTap': () => print('About program'),
      },
      {
        'icon': Icons.bug_report_outlined,
        'label': 'Сообщить об ошибке',
        'onTap': () => print('Message to support'),
      },
    ];

    return Scaffold(
      appBar: buildSettingsAppBar(context),
      backgroundColor: AppTheme.secondaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  const SizedBox(height: 20),
                  ...settings.take(3).map((setting) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _buildSettingItem(
                        icon: setting['icon'],
                        label: setting['label'],
                        onTap: setting['onTap'],
                      ),
                    );
                  }),
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
                  ...settings.skip(3).map((setting) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _buildSettingItem(
                        icon: setting['icon'],
                        label: setting['label'],
                        onTap: setting['onTap'],
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

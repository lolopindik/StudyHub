// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => AccountInfoState();
}

class AccountInfoState extends State<AccountInfo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Аккаунт',
          style: TextStyles.ruberoidRegular28,
        ),
        centerTitle: true,
        backgroundColor: AppTheme.mainColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
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
      ),
      backgroundColor: AppTheme.secondaryColor,
    );
  }
}

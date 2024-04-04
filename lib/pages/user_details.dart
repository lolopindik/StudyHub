import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
        color: AppTheme.mainColor,
        child: const Padding(
          padding: EdgeInsets.only(top: 100),
          child: Align(alignment: Alignment.topCenter,child: Text('User Info', style: TextStyles.ruberoidRegular40,),),
        ),
      )
    );
  }
}
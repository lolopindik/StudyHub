import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
        color: AppTheme.mainColor,
        child: const Padding(
          padding: EdgeInsets.only(top: 100),
          child: Align(alignment: Alignment.topCenter,child: Text('HOME PAGE', style: TextStyles.ruberoidRegular40,),),
        ),
      )
    );
  }
}
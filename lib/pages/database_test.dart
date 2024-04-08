import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/sign_appbar.dart';

class TestDataBase extends StatefulWidget {
  const TestDataBase({super.key});

  @override
  State<TestDataBase> createState() => _TestDataBaseState();
}

class _TestDataBaseState extends State<TestDataBase> {
  String textMessage = '';
  @override
  Widget build(BuildContext context) {
    DatabaseReference ref = FirebaseDatabase.instance.ref('test');
    ref.onValue.listen(
      (event) {
        setState(() {
          textMessage = event.snapshot.value.toString();
        });
      },
    );
    return Scaffold(
      backgroundColor: AppTheme.secondaryColor,
      appBar: buildSignAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 300,
            height: 450,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: AppTheme.mainColor),
            child: Center(
                child: Text(
              "Check database $textMessage",
              style: TextStyles.ruberoidLight32,
            )),
          ),
        ),
      ),
    );
  }
}

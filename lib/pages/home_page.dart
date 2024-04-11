// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/widgets/home_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  late String courseNumber;

  @override
  void initState() {
    super.initState();
    courseIteration();
  }

  void courseIteration() {
    String item = "course_";
    int? counter = 100;

    for (var i = 1; i <= counter; i++) {
      String currentCourseNumber = item + i.toString();
      compareTokens(currentCourseNumber);
    }
  }

  void compareTokens(String currentCourseNumber) async {
    DatabaseReference courseRef = FirebaseDatabase.instance.ref().child("Courses/$currentCourseNumber/token");
    DataSnapshot dataSnapshot = await courseRef.get();
    print('info from database: ${dataSnapshot.value}');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildHomeAppBar(context),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

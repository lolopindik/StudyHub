// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
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
  String? _userId;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    compareTokens();
  }

  void _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
    }
  }

  void compareTokens() async {
    //! "counter" используется для итераций по бд
    int? counter = 10;
    DatabaseReference userTokenRef = FirebaseDatabase.instance
        .ref()
        .child("UserDetails/$_userId/courseProgress/courseToken");
    DataSnapshot userTokenSnapshot = await userTokenRef.get();
    String? userToken = userTokenSnapshot.value as String?;

    String itemCourse = "course_";
    for (var i = 1; i <= counter; i++) {
      String currentCourseNumber = itemCourse + i.toString();
      DatabaseReference courseTokenRef = FirebaseDatabase.instance
          .ref()
          .child("Courses/$currentCourseNumber/token");
      DataSnapshot courseTokenSnapshot = await courseTokenRef.get();
      String? courseToken = courseTokenSnapshot.value as String?;

      if (courseToken != null) {
        if (userToken == courseToken) {
          print('Эквивалентные токены найдены:');
          print('Токен пользователя: $userToken');
          print('Токен курса $currentCourseNumber: $courseToken');
          DatabaseReference courseNameRef = FirebaseDatabase.instance
              .ref()
              .child("Courses/$currentCourseNumber/courseName");
          DataSnapshot courseNameSnapShot = await courseNameRef.get();
          String? courseName = courseNameSnapShot.value as String;
          print('Название курса: $courseName');
          String itemSubjects = "subject_";
          for (var i = 1; i <= counter; i++) {
            String currentSubjectNumber = itemSubjects + i.toString();
            DatabaseReference subjectItemRef = FirebaseDatabase.instance
                  .ref()
                  .child("Courses/$currentCourseNumber/subjects/$currentSubjectNumber/name");
            DataSnapshot subjectNameSnapShot = await subjectItemRef.get();
            String? subjectName = subjectNameSnapShot.value as String?;
            if(subjectName != null){
              print("Названия предметов: $subjectName");
            }
          }
        }
      }
    }
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

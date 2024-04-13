// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/pages/user_details.dart';
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
    compareTokens(context);
  }

  void _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
    }
  }

  void compareTokens(BuildContext context) async {
    int counter = 10; //! ограниченное число итераций по базе данных
    List<Map<String, dynamic>> coursesData = [];

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

      if (courseToken != null && userToken == courseToken) {
        DatabaseReference courseNameRef = FirebaseDatabase.instance
            .ref()
            .child("Courses/$currentCourseNumber/courseName");
        DataSnapshot courseNameSnapshot = await courseNameRef.get();
        String? courseName = courseNameSnapshot.value as String?;

        if (courseName != null) {
          Map<String, dynamic> courseData = {
            'courseName': courseName,
            'subjects': <Map<String, dynamic>>[]
          };

          String itemSubjects = "subject_";
          for (var j = 1; j <= counter; j++) {
            String currentSubjectNumber = itemSubjects + j.toString();
            DatabaseReference subjectItemRef = FirebaseDatabase.instance
                .ref()
                .child(
                    "Courses/$currentCourseNumber/subjects/$currentSubjectNumber");
            DataSnapshot subjectSnapshot = await subjectItemRef.get();
            Map<dynamic, dynamic>? subjectData =
                subjectSnapshot.value as Map<dynamic, dynamic>?;

            if (subjectData != null) {
              Map<String, dynamic> subjectDetails = {
                'name': subjectData['name'],
                'lessons': <Map<String, dynamic>>[]
              };

              // Добавление параметра lessonComplete для каждого урока
              subjectData['lessons'].forEach((key, value) {
                Map<String, dynamic> lessonDetails = {
                  'name': value['name'],
                  'documents': value['documents'],
                };

                // Проверка, был ли урок уже отмечен как завершенный
                if (value['lessonComplete'] == null) {
                  // Если урок не был отмечен как завершенный, устанавливаем значение по умолчанию (0)
                  lessonDetails['lessonComplete'] = 0;
                } else {
                  // Если урок уже был отмечен как завершенный, оставляем текущее значение
                  lessonDetails['lessonComplete'] = value['lessonComplete'];
                }

                (subjectDetails['lessons'] as List<Map<String, dynamic>>)
                    .add(lessonDetails);
              });

              (courseData['subjects'] as List<Map<String, dynamic>>)
                  .add(subjectDetails);
            }
          }
          coursesData.add(courseData);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Указан неверный токен!'),
          ),
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const UserData(),
          ),
        );
        return; // останавливаем выполнение функции
      }
    }

    // Обновление данных пользователя в базе данных
    DatabaseReference userCourseRef = FirebaseDatabase.instance
        .ref()
        .child("UserDetails/$_userId/courseProgress");
    await userCourseRef.update({"coursesData": coursesData});

    print(coursesData);
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

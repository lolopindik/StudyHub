// ignore_for_file: file_names, avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  static final FirebaseService _singleton = FirebaseService._internal();
  factory FirebaseService() => _singleton;
  FirebaseService._internal();

  final auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<bool> isFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_time') ?? true;
  }

  Future<void> setFirstLaunch(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first_time', value);
  }

  onListenUser(void Function(User?)? doListen) {
    FirebaseAuth.instance.authStateChanges().listen(doListen);
  }

  logOut() async {
    await auth.signOut();
  }

  Future<void> deleteAcc(String userId) async {
    try {
      await FirebaseDatabase.instance.ref("UserDetails/$userId/").remove();
      await FirebaseAuth.instance.currentUser?.delete();
    } catch (error) {
      print("Ошибка при удалении аккаунта: $error");
    }
  }

// лучше не использовать из-за багов
  verifyemail() async {
    await currentUser?.sendEmailVerification();
    print('verify sended');
  }
}

Future<List<Map<String, dynamic>>> compareTokens(String? userId) async {
  DatabaseReference userCourseRef = FirebaseDatabase.instance
      .ref()
      .child("UserDetails/$userId/courseProgress");
  DataSnapshot userCourseSnapshot = await userCourseRef.get();
  Map<dynamic, dynamic>? userCourseData =
      userCourseSnapshot.value as Map<dynamic, dynamic>?;

  if (userCourseData != null) {
    String? userToken = userCourseData['courseToken'] as String?;
    DatabaseReference coursesRef =
        FirebaseDatabase.instance.ref().child("Courses");
    DataSnapshot coursesSnapshot = await coursesRef.get();
    Map<dynamic, dynamic>? coursesData =
        coursesSnapshot.value as Map<dynamic, dynamic>?;
    if (coursesData != null) {
      List<Map<String, dynamic>> matchedCourses = [];
      for (var courseEntry in coursesData.entries) {
        var courseKey = courseEntry.key;
        var courseValue = courseEntry.value;
        if (courseValue['token'] == userToken) {
          Map<String, dynamic> matchedCourse = {
            'courseName': courseValue['courseName'],
            'subjects': <Map<String, dynamic>>[]
          };
          Map<dynamic, dynamic>? subjects =
              courseValue['subjects'] as Map<dynamic, dynamic>?;
          if (subjects != null) {
            for (var subjectEntry in subjects.entries) {
              var subjectKey = subjectEntry.key;
              var subjectValue = subjectEntry.value;
              Map<String, dynamic> matchedSubject = {
                'name': subjectValue['name'],
                'lessons': <Map<String, dynamic>>[]
              };
              Map<dynamic, dynamic>? lessons =
                  subjectValue['lessons'] as Map<dynamic, dynamic>?;
              if (lessons != null) {
                for (var lessonEntry in lessons.entries) {
                  var lessonKey = lessonEntry.key;
                  var lessonValue = lessonEntry.value;
                  Map<String, dynamic> matchedLesson = {
                    'name': lessonValue['name'],
                    'materials': {}
                  };
                  if (lessonValue['materials'] != null) {
                    matchedLesson['materials'] = {};
                    // Обработка материалов
                    Map<dynamic, dynamic>? materials =
                        lessonValue['materials'] as Map<dynamic, dynamic>?;
                    materials?.forEach((materialKey, materialValue) {
                      matchedLesson['materials'][materialKey] = materialValue;
                    });
                    // Обработка вложенных объектов в материалах
                    if (materials?['test'] != null) {
                      Map<String, dynamic> test = {
                        'question': materials?['test']['question'],
                        'anwers':
                            List<String>.from(materials?['test']['anwers']),
                        'correct_anwer': materials?['test']['correct_anwer']
                      };
                      matchedLesson['materials']['test'] = test;
                    }
                    if (materials?['entry_field'] != null) {
                      matchedLesson['materials']['entry_field'] =
                          materials?['entry_field'];
                    }
                    if (materials?['theory'] != null) {
                      matchedLesson['materials']['theory'] =
                          materials?['theory'];
                    }
                  }
                  // Проверка прогресса: если 'completed' уже существует и > 0, не перезаписываем
                  DatabaseReference progressRef = FirebaseDatabase.instance
                      .ref()
                      .child(
                          'progress/$userId/$courseKey/$subjectKey/$lessonKey');
                  DataSnapshot progressSnapshot = await progressRef.get();

                  var progressData =
                      progressSnapshot.value as Map<dynamic, dynamic>?;
                  if (progressData == null ||
                      (progressData['completed'] ?? 0) <= 0) {
                    // Обновляем, если не существует или значение 'completed' <= 0
                    await progressRef.set({
                      'lesson_name': lessonValue['name'],
                      'completed': 0,
                    });
                  }
                  matchedSubject['lessons'].add(matchedLesson);
                }
              }
              matchedCourse['subjects'].add(matchedSubject);
            }
          }
          matchedCourses.add(matchedCourse);
        }
      }
      return matchedCourses;
    }
  }
  return [];
}

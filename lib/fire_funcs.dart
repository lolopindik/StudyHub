// ignore_for_file: file_names, avoid_print

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

// лучше не использовать из-за багов
  verifyemail() async {
    await currentUser?.sendEmailVerification();
    print('verify sended');
  }
}

Future<List<Map<String, dynamic>>> compareTokens(String? userId) async {
  int counter = 10; //! ограниченное число итераций по базе данных
  bool tokenFound = false;
  List<Map<String, dynamic>> coursesData = [];

  DatabaseReference userCourseRef = FirebaseDatabase.instance
      .ref()
      .child("UserDetails/$userId/courseProgress");

  // Получаем текущие данные о прогрессе курса пользователя
  DataSnapshot userCourseSnapshot = await userCourseRef.get();
  Map<dynamic, dynamic>? userCourseData =
      userCourseSnapshot.value as Map<dynamic, dynamic>?;

  // Если данные о прогрессе курса пользователя существуют, обновляем их
  if (userCourseData != null) {
    // Получаем текущий токен пользователя
    String? userToken = userCourseData['courseToken'] as String?;

    String itemCourse = "course_";
    for (var i = 1; i <= counter; i++) {
      String currentCourseNumber = itemCourse + i.toString();
      DatabaseReference courseTokenRef = FirebaseDatabase.instance
          .ref()
          .child("Courses/$currentCourseNumber/token");
      DataSnapshot courseTokenSnapshot = await courseTokenRef.get();
      String? courseToken = courseTokenSnapshot.value as String?;

      if (courseToken != null && userToken == courseToken) {
        tokenFound = true;
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

              subjectData['lessons'].forEach((key, value) {
                int? lessonCompleteFromDB = value['lessonComplete'];
                int defaultLessonComplete = 0;
                if (userCourseData['coursesData'] != null && userCourseData['coursesData'][i - 1]['subjects'] != null && userCourseData['coursesData'][i - 1]['subjects'][j - 1] != null) {
                  var userLessonComplete = userCourseData['coursesData'][i - 1]['subjects'][j - 1]['lessons'].firstWhere(
                      (lesson) => lesson['name'] == value['name'],
                      orElse: () => null);
                  if (userLessonComplete != null && userLessonComplete['lessonComplete'] != null) {
                    lessonCompleteFromDB = userLessonComplete['lessonComplete'];
                  }
                }

                Map<String, dynamic> lessonDetails = {
                  'name': value['name'],
                  'documents': value['documents'],
                  'lessonComplete': lessonCompleteFromDB ?? defaultLessonComplete,
                };

                (subjectDetails['lessons'] as List<Map<String, dynamic>>)
                    .add(lessonDetails);
              });

              (courseData['subjects'] as List<Map<String, dynamic>>)
                  .add(subjectDetails);
            }
          }
          coursesData.add(courseData);
        }
      }
    }

    // Обновляем только courseData в текущих данных о прогрессе курса пользователя
    await userCourseRef.update({
      "coursesData": coursesData,
    });
  }

  if (!tokenFound) {
    // Проверяем, был ли найден токен после всех итераций
    return []; // возвращаем пустой список
  }

  // Возвращаем только courseProgress
  return coursesData;
}


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:study_hub/pages/home/home_page.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/appbars/sign_appbar.dart';
import 'package:study_hub/widgets/forms/user_form.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final fullnameController = TextEditingController();
  final tokenController = TextEditingController();

  String? _userId;
  String _selectedCourse = '';
  final List<String> _courses = [];
  final Map<String, String> _courseTokens = {};

  final DatabaseReference _coursesRef =
      FirebaseDatabase.instance.ref().child('Courses');

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _fetchCourses();
  }

  void _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
    }
  }

  void _fetchCourses() {
  _coursesRef.get().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic>? coursesData = snapshot.value as Map<dynamic, dynamic>?; 
    if (coursesData != null) {
      coursesData.forEach((key, value) {
        String courseName = value['courseName'];
        String token = value['token'];
        if (!_courses.contains(courseName)) {
          _courses.add(courseName);
          _courseTokens[courseName] = token;
        }
      });
      setState(() {
        if (!_courses.contains(_selectedCourse) && _courses.isNotEmpty) {
          _selectedCourse = _courses[0];
        }
      });
    }
  }).catchError((error) {
    debugPrint("Error fetching courses: $error");
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mainColor,
      appBar: buildSignAppBar(context),
      body: UserDataForm(
        fullnameController: fullnameController,
        tokenController: tokenController,
        sendDataToFirebase: sendDataToFirebase,
        navigateToHomepage: navigateToHomepage,
        courses: _courses,
        selectedCourse: _selectedCourse,
        onCourseChanged: (String? newValue) {
          setState(() {
            _selectedCourse = newValue!;
          });
        },
      ),
    );
  }

  void sendDataToFirebase() {
    String fullname = fullnameController.text;
    String courseToken = _courseTokens[_selectedCourse] ?? '';

    if (fullname.isNotEmpty && _selectedCourse.isNotEmpty && _userId != null) {
      Map<String, dynamic> courseProgress = {
        'courseToken': courseToken,
      };

      Map<String, dynamic> userData = {
        'fullname': fullname,
        'courseProgress': courseProgress,
      };

      DatabaseReference userDetailsRef =
          FirebaseDatabase.instance.ref().child('UserDetails').child(_userId!);
      userDetailsRef.set(userData).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Данные успешно отправлены', style: TextStyles.ruberoidLight16),
          ),
        );
        navigateToHomepage();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Не удалось отправить данные: $error', style: TextStyles.ruberoidLight16),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Поля пусты или пользователь не аутентифицирован', style: TextStyles.ruberoidLight16),
        ),
      );
    }
  }

  void navigateToHomepage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }
}

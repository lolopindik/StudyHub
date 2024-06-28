import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:study_hub/preferences/app_theme.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => AccountInfoState();
}

class AccountInfoState extends State<AccountInfo> {
  String? currentUsername;
  String? selectedCourse;
  String? selectedCourseToken;
  final List<String> _courses = [];
  final DatabaseReference _coursesRef =
      FirebaseDatabase.instance.ref().child('Courses');
  final DatabaseReference _userDetailsRef =
      FirebaseDatabase.instance.ref().child('UserDetails');

  final TextEditingController _fullnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _fetchCurrentUser();
    await _fetchCurrentUserCourse();
    _fetchCourses();
  }

  Future<void> _fetchCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DataSnapshot snapshot =
          await _userDetailsRef.child(user.uid).child('fullname').get();
      if (snapshot.value != null) {
        setState(() {
          currentUsername = snapshot.value as String?;
          _fullnameController.text = currentUsername ?? 'Loading...';
        });
      }
    }
  }

  Future<void> _fetchCurrentUserCourse() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DataSnapshot snapshot = await _userDetailsRef
          .child(user.uid)
          .child('courseProgress')
          .child('courseToken')
          .get();
      if (snapshot.value != null) {
        String token = snapshot.value as String;
        await _fetchCourseNameByToken(token);
        debugPrint('course token: $token');
      }
    }
  }

  Future<void> _fetchCourseNameByToken(String token) async {
    DataSnapshot snapshot = await _coursesRef.get();
    Map<dynamic, dynamic>? coursesData =
        snapshot.value as Map<dynamic, dynamic>?;
    if (coursesData != null) {
      coursesData.forEach((key, value) {
        if (value['token'] == token) {
          setState(() {
            selectedCourse = value['courseName'] as String?;
            selectedCourseToken = token;
          });
        }
      });
    }
  }

  Future<void> _fetchCourses() async {
    try {
      DataSnapshot snapshot = await _coursesRef.get();
      Map<dynamic, dynamic>? coursesData =
          snapshot.value as Map<dynamic, dynamic>?;

      if (coursesData != null) {
        setState(() {
          _courses.clear();
          coursesData.forEach((key, value) {
            String courseName = value['courseName'] ?? "Loading...";
            _courses.add(courseName);
          });

          if (!_courses.contains(selectedCourse) && _courses.isNotEmpty) {
            selectedCourse = _courses[0];
          }
        });
      }
    } catch (error) {
      debugPrint("Error fetching courses: $error");
    }
  }

  Future<String?> _fetchCourseTokenByName(String courseName) async {
    DataSnapshot snapshot = await _coursesRef.get();
    Map<dynamic, dynamic>? coursesData =
        snapshot.value as Map<dynamic, dynamic>?;
    if (coursesData != null) {
      for (var course in coursesData.values) {
        if (course['courseName'] == courseName) {
          return course['token'] as String?;
        }
      }
    }
    return null;
  }

  void _showSuccessSnackbar() {
    const snackBar = SnackBar(
      content: Text(
        'Данные обновлены',
        style: TextStyles.ruberoidLight16,
      ),
      backgroundColor: AppTheme.mainColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void updateFullNameInfo() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userDetailsRef
          .child(user.uid)
          .update({'fullname': _fullnameController.text});
    }
  }

  void _updateCourseInfo(String token) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userDetailsRef
          .child(user.uid)
          .child('courseProgress')
          .update({'courseToken': token});
    }
    _showSuccessSnackbar();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            onChanged: (value) {
              _fullnameController.text = value;
              updateFullNameInfo();
            },
            controller: _fullnameController,
            style: TextStyles.ruberoidLight20,
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'ФИО',
              labelStyle: TextStyles.ruberoidLight16,
            ),
          ),
          DropdownButton<String>(
            value: selectedCourse,
            dropdownColor: AppTheme.mainColor,
            onChanged: (String? newValue) async {
              if (newValue != null) {
                setState(() {
                  selectedCourse = newValue;
                });
                String? token =
                    await _fetchCourseTokenByName(newValue);
                if (token != null) {
                  setState(() {
                    selectedCourseToken = token;
                  });
                  _updateCourseInfo(selectedCourseToken!);
                }
              }
            },
            items: _courses.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyles.ruberoidLight20,
                  ),
                );
              },
            ).toList(),
            underline: Container(),
          ),
        ],
      ),
    );
  }
}
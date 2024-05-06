// ignore_for_file: avoid_print

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
      content: Text('Данные успешно изменены', style: TextStyles.ruberoidLight16,),
      backgroundColor: AppTheme.mainColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _updateFullNameInfo() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userDetailsRef
          .child(user.uid)
          .update({'fullname': _fullnameController.text});
          _showSuccessSnackbar();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Аккаунт',
          style: TextStyles.ruberoidRegular28,
        ),
        centerTitle: true,
        backgroundColor: AppTheme.mainColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.secondaryColor,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 23,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: AppTheme.secondaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              TextFormField(
                controller: _fullnameController,
                style: TextStyles.ruberoidLight16,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'ФИО',
                    labelStyle: TextStyles.ruberoidLight16),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedCourse,
                dropdownColor: AppTheme.mainColor,
                onChanged: (String? newValue) async {
                  if (newValue != null) {
                    setState(() {
                      selectedCourse = newValue;
                    });
                    String? token = await _fetchCourseTokenByName(newValue);
                    if (token != null) {
                      setState(() {
                        selectedCourseToken = token;
                      });
                      _updateCourseInfo(selectedCourseToken!);
                    }
                  }
                },
                items: _courses.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyles.ruberoidLight16,
                    ),
                  );
                }).toList(),
                underline: Container(),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    print('chanched data');
                    _updateFullNameInfo();
                  },
                  child: Container(
                    width: 240,
                    height: 51,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: AppTheme.mainColor,
                    ),
                    child: const Center(
                      child: Text(
                        'Редактировать',
                        style: TextStyles.ruberoidLight20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

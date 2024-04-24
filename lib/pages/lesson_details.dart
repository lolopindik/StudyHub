// ignore_for_file: avoid_print, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/customLoadingIndicator.dart';
import 'package:study_hub/widgets/lessons_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LessonDetails extends StatefulWidget {
  final Map<String, dynamic> lessonData;

  const LessonDetails({super.key, required this.lessonData});

  @override
  LessonDetailsState createState() => LessonDetailsState();
}

class LessonDetailsState extends State<LessonDetails> {
  final inputAnswer = TextEditingController();
  String? _userId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentUser().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    if (widget.lessonData['userAnswer'] != null) {
      inputAnswer.text = widget.lessonData['userAnswer'];
    }
  }

  Future<void> _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CustomLoadingIndicator(),
        ),
      );
    }

    List<dynamic> documents =
        widget.lessonData['documents']?.values.toList() ?? [];

    return Scaffold(
      appBar: buildLessonAppBar(context),
      backgroundColor: AppTheme.secondaryColor,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.103,
            color: AppTheme.mainElementColor,
            constraints: const BoxConstraints(minHeight: 60),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Text(
                      widget.lessonData['name'] ?? 'Lesson',
                      style: constraints.maxWidth > 150
                          ? TextStyles.ruberoidRegular20
                          : TextStyles.ruberoidRegular28,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final String documentUrl = documents[index] as String;
                return GestureDetector(
                  onTap: () {
                    launch(documentUrl);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: AppTheme.mainElementColor,
                    ),
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                    height: MediaQuery.of(context).size.height * 0.08,
                    constraints: const BoxConstraints(minHeight: 60),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.description,
                              color: Colors.white54,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Text(
                                documentUrl,
                                style: TextStyles.ruberoidLight16,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                color: AppTheme.mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorHeight: 18,
                      controller: inputAnswer,
                      decoration: const InputDecoration(
                        hintText: 'Your Answer...',
                        hintStyle: TextStyles.ruberoidLight20,
                        enabledBorder: InputBorder.none,
                      ),
                      style: TextStyles.ruberoidLight16,
                      cursorColor: Colors.white,
                      textAlignVertical: TextAlignVertical.top,
                      expands: true,
                      maxLines: null,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 20),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.secondaryColor,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white54,
                          ),
                          onPressed: () async {
                            String answer = inputAnswer.text;
                            if (answer.isEmpty) {
                              return;
                            }
                            int lessonComplete =
                                widget.lessonData['lessonComplete'] ?? 0;
                            if (lessonComplete == 2) {
                              _showConfirmationDialog(answer);
                              return;
                            }
                            sendDataToFirebase(
                              _userId!,
                              widget.lessonData['name'] ?? '',
                              answer,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendDataToFirebase(
      String userId, String lessonName, String answer) async {
    DatabaseReference userCourseRef = FirebaseDatabase.instance
        .reference()
        .child("UserDetails/$userId/courseProgress");
    DataSnapshot userCourseSnapshot = await userCourseRef.get();
    Map<dynamic, dynamic>? userCourseData =
        userCourseSnapshot.value as Map<dynamic, dynamic>?;
    if (userCourseData != null) {
      List<dynamic> coursesData =
          (userCourseData['coursesData'] as List<dynamic>).toList();

      bool lessonFound = false;

      for (var courseData in coursesData) {
        List<dynamic>? subjects = courseData['subjects'];
        if (subjects != null) {
          for (var subject in subjects) {
            List<dynamic>? lessons = subject['lessons'];
            if (lessons != null) {
              for (var lesson in lessons) {
                if (lesson['name'] == lessonName) {
                  lesson['userAnswer'] = answer;
                  lesson['lessonComplete'] = 3;
                  lessonFound = true;
                  break;
                }
              }
            }
            if (lessonFound) {
              break;
            }
          }
        }
        if (lessonFound) {
          break;
        }
      }

      if (!lessonFound) {
        Map<String, dynamic> newLesson = {
          'name': lessonName,
          'userAnswer': answer,
          'lessonComplete': 3,
        };

        for (var courseData in coursesData) {
          List<dynamic>? subjects = courseData['subjects'];
          if (subjects != null && subjects.isNotEmpty) {
            (subjects.first['lessons'] as List).add(newLesson);
            break;
          }
        }
      }

      await userCourseRef.update({
        "coursesData": coursesData,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ответ успешно отправлен'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Данные не были отправлены'),
        ),
      );
    }
  }

  Future<void> _showConfirmationDialog(String answer) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.mainColor,
          surfaceTintColor: Colors.transparent,
          title: const Text(
            "Предупреждение!",
            style: TextStyles.ruberoidLight20,
          ),
          content: const Text(
            "Вы уверены, что хотите заменить верный ответ? Для его подтверждения нужна будет повторная проверка",
            style: TextStyles.ruberoidLight16,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Отмена",
                style: TextStyles.ruberoidLight16,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                sendDataToFirebase(
                  _userId!,
                  widget.lessonData['name'] ?? '',
                  answer,
                );
              },
              child: const Text(
                "Подтвердить",
                style: TextStyles.ruberoidLight16,
              ),
            ),
          ],
        );
      },
    );
  }
}

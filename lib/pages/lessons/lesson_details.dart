// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:study_hub/backend/fire_funcs.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/appbars/lessons_appbar.dart';
import 'package:study_hub/widgets/elements/details/entry_field/entry_field.dart';
import 'package:study_hub/widgets/elements/details/test_/test_widget.dart';
import 'package:study_hub/widgets/elements/details/webview/url_widget.dart';
import 'package:study_hub/widgets/elements/details/theory_widget.dart';
import 'package:study_hub/widgets/elements/loading/cupertinoLoadingIndicator.dart';
import 'package:study_hub/widgets/elements/loading/customLoadingIndicator.dart';

class LessonDetails extends StatefulWidget {
  final Map<String, dynamic> lessonData;

  const LessonDetails({super.key, required this.lessonData});

  @override
  _LessonDetailsState createState() => _LessonDetailsState();
}

class _LessonDetailsState extends State<LessonDetails> {
  TextEditingController inputAnswer = TextEditingController();
  int? selectedAnswerIndex;
  bool enebled = true;
  bool isLoading = true;
  late String subjectId;
  late String lessonId;
  late String courseId;

  @override
  void initState() {
    super.initState();
    courseId = widget.lessonData['courseId'];
    subjectId = widget.lessonData['subjectId'];
    lessonId = widget.lessonData['lessonId'];
    debugPrint('subjectId and lessonId: $subjectId & $lessonId');
    loadData();
  }

  Future<void> loadData() async {
    loadEntryFieldResponse();
    await loadSelectedAnswerFromFirebase();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> saveSelectedAnswerToFirebase(
      int selectedIndex, int? correctIntAnswer) async {
    setState(() {
      selectedAnswerIndex = selectedIndex;
      enebled = false;
    });

    final userId = FirebaseAuth.instance.currentUser!.uid;
    final DatabaseReference ref = FirebaseDatabase.instance
        .ref('progress/$userId/$courseId/$subjectId/$lessonId');
    int completionStatus = (selectedIndex == correctIntAnswer) ? 3 : 1;

    await ref.update({
      'selectedAnswer': selectedIndex,
      'completed': completionStatus,
    });
  }

  Future<void> loadSelectedAnswerFromFirebase() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final DatabaseReference ref = FirebaseDatabase.instance
        .ref('progress/$userId/$courseId/$subjectId/$lessonId/selectedAnswer');

    final snapshot = await ref.get();
    if (snapshot.exists) {
      setState(() {
        selectedAnswerIndex = snapshot.value as int?;
        enebled = false;
      });
    }
  }

  void loadEntryFieldResponse() async {
    String? savedResponse =
        await getEntryFieldResponse(courseId, subjectId, lessonId);
    if (savedResponse != null) {
      setState(() {
        inputAnswer.text = savedResponse;
        debugPrint('savedResponse: "$savedResponse"');
      });
    }
  }

  void submitAnswer() async {
    await setEntryFieldResponse(
        courseId, subjectId, lessonId, inputAnswer.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ответ отправлен на проверку',
            style: TextStyles.ruberoidLight16),
      ),
    );
  }

  void sendingReply() async {
    await setCompleted(courseId, subjectId, lessonId);
    debugPrint('Пользователь перешел по ссылке');
  }

  void _disableTest() {
    setState(() {
      enebled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? test;

    if (widget.lessonData['materials']?['test'] != null) {
      test = Map<String, dynamic>.from(
          widget.lessonData['materials']?['test'] as Map);
    } else {
      test = null;
    }

    List<dynamic>? answers = test?['anwers'];
    String url = widget.lessonData['materials']?['url'] ?? '';
    String theory = widget.lessonData['materials']?['theory'] ?? '';
    String question = test?['question'] ?? '';
    String correctAnswer = test?['correct_anwer'] ?? '';
    bool entryField = widget.lessonData['materials']?['entry_field'] ?? false;

    int? correctIntAnswer;
    if (correctAnswer.isNotEmpty) {
      correctIntAnswer = int.tryParse(correctAnswer);
    }

    if (isLoading) {
      return Center(
          child: Platform.isIOS
              ? const CupertinoTransparentIndicator()
              : const CustomTransparentLoadingIndicator());
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        appBar: buildLessonAppBar(context),
        backgroundColor: AppTheme.secondaryColor,
        body: Stack(
          children: [
            RawScrollbar(
              thumbColor: Colors.white70,
              thickness: 2,
              radius: const Radius.circular(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.103,
                      color: AppTheme.mainElementColor,
                      constraints: const BoxConstraints(minHeight: 60),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: AutoSizeText(
                            widget.lessonData['name'] ?? 'Lesson',
                            style: TextStyles.ruberoidRegular20,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (theory.isNotEmpty) buildTheory(context, theory),
                        if (url.isNotEmpty) ...{
                          const SizedBox(height: 20),
                          buildUrl(context, url, sendingReply),
                        },
                        if (answers != null && question.isNotEmpty) ...{
                          buildTestWidget(
                            question,
                            answers,
                            correctIntAnswer,
                            selectedAnswerIndex,
                            enebled,
                            (index) {
                              setState(() {
                                saveSelectedAnswerToFirebase(
                                    index, correctIntAnswer);
                                debugPrint(
                                    'Индекс ответа: $selectedAnswerIndex, Правильный ответ: $correctIntAnswer');
                              });
                            },
                            _disableTest,
                          ),
                        },
                        const SizedBox(height: 40),
                        if (entryField) const SizedBox(height: 80),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (entryField) buildEntryField(context, inputAnswer, submitAnswer),
          ],
        ),
      ),
    );
  }
}

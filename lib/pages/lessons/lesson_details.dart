import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/appbars/lessons_appbar.dart';
import 'package:study_hub/widgets/elements/details/entry_field.dart';
import 'package:study_hub/widgets/elements/details/test_widget.dart';
import 'package:study_hub/widgets/elements/details/url_widget.dart';
import 'package:study_hub/widgets/elements/details/theory_widget.dart';

class LessonDetails extends StatefulWidget {
  final Map<String, dynamic> lessonData;

  const LessonDetails({super.key, required this.lessonData});

  @override
  _LessonDetailsState createState() => _LessonDetailsState();
}

class _LessonDetailsState extends State<LessonDetails> {
  TextEditingController inputAnswer = TextEditingController();
  int? selectedAnswerIndex;

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

    //*parse
    int? correctIntAnswer;
    if (correctAnswer.isNotEmpty) {
      correctIntAnswer = int.tryParse(correctAnswer);
    }

    return Scaffold(
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
                      if (theory.isNotEmpty) bulldTheory(context, theory),
                      if (url.isNotEmpty) ...{
                        const SizedBox(height: 20),
                        buildUrl(context, url),
                      },
                      if (answers != null && question.isNotEmpty) ...{
                        buildTestWidget(
                          question,
                          answers,
                          correctIntAnswer,
                          selectedAnswerIndex,
                          (index) {
                            setState(() {
                              selectedAnswerIndex = index;
                              debugPrint(
                                  'Индекс ответа: $selectedAnswerIndex, Правильный ответ: $correctIntAnswer');
                            });
                          },
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
          if (entryField) buildEntryField(context, inputAnswer),
        ],
      ),
    );
  }
}
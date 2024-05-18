// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/lessons_appbar.dart';

class LessonDetails extends StatefulWidget {
  final Map<String, dynamic> lessonData;

  const LessonDetails({super.key, required this.lessonData});

  @override
  _LessonDetailsState createState() => _LessonDetailsState();
}

class _LessonDetailsState extends State<LessonDetails> {
  TextEditingController inputAnswer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Получение данных теории
    Map<String, dynamic>? test = widget.lessonData['materials']['test'];
    List<dynamic>? answers = test?['anwers'];
    String theory = widget.lessonData['materials']['theory'] ?? '';
    String question = test?['question'] ?? '';
    bool entryField = widget.lessonData['materials']['entry_field'] ?? false;

    return Scaffold(
      appBar: buildLessonAppBar(context),
      backgroundColor: AppTheme.secondaryColor,
      body: RawScrollbar(
        thumbColor: Colors.white70,
        thickness: 2,
        radius: const Radius.circular(10.0),
        child: SingleChildScrollView(
          child: Column(
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (theory.isNotEmpty) ...[
                      Text(
                        theory,
                        style: TextStyles.ruberoidLight16,
                      ),
                      const SizedBox(height: 20),
                    ],
                    if (question.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Text(
                        question,
                        style: TextStyles.ruberoidLight16,
                      ),
                      const SizedBox(height: 20),
                      if (answers != null) ...[
                        const Text(
                          'Answers:',
                          style: TextStyles.ruberoidLight16,
                        ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: answers.map<Widget>((answer) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  answer.toString(),
                                  style: TextStyles.ruberoidLight16,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ],
                    if (entryField) ...[
                      TextField(
                        controller: inputAnswer,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your answer',
                          labelStyle: TextStyles.ruberoidLight16,
                          hintStyle: TextStyles.ruberoidLight16
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

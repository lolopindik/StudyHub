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
                      child: Text(widget.lessonData['name'] ?? 'Lesson',
                          style: TextStyles.ruberoidRegular20)),
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
                        style: TextStyles.ruberoidLight20,
                      ),
                      const SizedBox(height: 40),
                    ],
                    if (answers != null && question.isNotEmpty) ...[
                      Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 450),
                          decoration: const BoxDecoration(
                            color: AppTheme.mainColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Center(
                                  child: Text(
                                    question,
                                    style: TextStyles.ruberoidLight20,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow
                                        .clip,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 10,
                          color: AppTheme.mainElementColor,
                          constraints: const BoxConstraints(maxWidth: 450),
                        ),
                      ),
                      Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 450),
                          child: ListView.builder(
                            shrinkWrap:true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: answers.length,
                            itemBuilder: (context, index) {
                              bool isLastIndex = index == answers.length - 1;
                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  return Column(
                                    children: [
                                      Container(
                                        constraints:
                                            const BoxConstraints(minHeight: 35),
                                        decoration: BoxDecoration(
                                          color: AppTheme.mainElementColor,
                                          borderRadius: isLastIndex
                                              ? const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
                                                )
                                              : BorderRadius.zero,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.08,
                                            decoration: BoxDecoration(
                                              color: AppTheme.mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Text(
                                                  answers[index].toString(),
                                                  style: TextStyles
                                                      .ruberoidLight18,
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.clip),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 40),
                    if (entryField) ...[
                      TextField(
                        controller: inputAnswer,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your answer',
                          labelStyle: TextStyles.ruberoidLight16,
                          hintStyle: TextStyles.ruberoidLight16,
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

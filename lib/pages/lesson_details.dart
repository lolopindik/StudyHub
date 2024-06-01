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
        thumbColor: AppTheme.mainColor,
        thickness: 4,
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
                    child: Text(widget.lessonData['name'] ?? 'Lesson',
                        style: TextStyles.ruberoidRegular20),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (theory.isNotEmpty)
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 15, right: 10),
                      child: Text(
                        theory,
                        style: TextStyles.ruberoidLight20,
                      ),
                    ),
                  const SizedBox(height: 40),
                  if (answers != null && question.isNotEmpty)
                    Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 450),
                              decoration: const BoxDecoration(
                                color: AppTheme.mainColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                              ),
                              padding: const EdgeInsets.all(15),
                              child: Center(
                                child: Text(
                                  question,
                                  style: TextStyles.ruberoidRegular20,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 450),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: answers.length,
                                itemBuilder: (context, index) {
                                  bool isLastIndex =
                                      index == answers.length - 1;
                                  return Column(
                                    children: [
                                      Container(
                                        constraints:
                                            const BoxConstraints(minHeight: 60),
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
                                              horizontal: 10, vertical: 12),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.08,
                                            decoration: BoxDecoration(
                                              color: AppTheme.mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                            ),
                                            child: Center(
                                              child: Text(
                                                answers[index].toString(),
                                                style:
                                                    TextStyles.ruberoidLight18,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 40),
                  if (entryField)
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet<void>(
                          backgroundColor: AppTheme.mainColor,
                          context: context,
                          builder: (BuildContext context) {
                            return buildBottomSheet(context);
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.1,
                        constraints: const BoxConstraints(minHeight: 80),
                        decoration: const BoxDecoration(
                          color: AppTheme.mainColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text(
                                  'Введите ответ: ',
                                  style: TextStyles.ruberoidRegular20,
                                ),
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.secondaryColor,
                                  ),
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBottomSheet(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 15),
            child: TextField(
              controller: inputAnswer,
              cursorHeight: 18,
              decoration: const InputDecoration(
                hintText: 'Введите ответ: ',
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
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:25,right: 20, bottom: 10),
              child: Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.secondaryColor,
                ),
                child: IconButton(
                  onPressed: () {
                    debugPrint(inputAnswer.text);
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

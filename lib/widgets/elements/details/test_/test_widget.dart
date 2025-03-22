import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/elements/details/test_/test_dialog.dart';

Widget buildTestWidget(
    String question,
    List<dynamic> answers,
    int? correctIntAnswer,
    int? selectedAnswerIndex,
    bool enebled,
    VoidCallback removeSelectedAnswerToFirebase,
    Function(int) onAnswerSelected, Function disableTest) {
  return Column(
    children: [
      const SizedBox(height: 40),
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
              child: AutoSizeText(
                question,
                style: TextStyles.ruberoidRegular20,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                maxLines: 2,
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
                bool isLastIndex = index == answers.length - 1;
                bool isSelected = selectedAnswerIndex == index;
                bool isCorrect = isSelected && index == correctIntAnswer;
                return Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(60),
                      onTap: () {
                        if (enebled) {
                          onAnswerSelected(index);
                          disableTest(); 
                        } else {
                          showTestDialog(context, removeSelectedAnswerToFirebase);
                        }
                      },
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 60),
                        decoration: BoxDecoration(
                          color: AppTheme.mainElementColor,
                          borderRadius: isLastIndex
                              ? const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                )
                              : BorderRadius.zero,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? (isCorrect
                                      ? const LinearGradient(
                                          colors: [
                                            AppTheme.mainElementColor,
                                            AppTheme.lessonCompleteGreen
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                      : const LinearGradient(
                                          colors: [
                                            AppTheme.mainColor,
                                            AppTheme.lessonCompleteRed
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ))
                                  : LinearGradient(
                                      colors: [
                                        AppTheme.mainElementColor,
                                        AppTheme.mainElementColor
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: AutoSizeText(
                                  answers[index],
                                  style: TextStyles.ruberoidLight18,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ),
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
  );
}
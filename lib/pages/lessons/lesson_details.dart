import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/pages/lessons/webview_page.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/appbars/lessons_appbar.dart';

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
    String url = widget.lessonData['materials']['url'] ?? '';
    String theory = widget.lessonData['materials']['theory'] ?? '';
    String question = test?['question'] ?? '';
    bool entryField = widget.lessonData['materials']['entry_field'] ?? false;

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
                      if (theory.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 15, right: 10),
                          child: Text(
                            textAlign: TextAlign.start,
                            theory,
                            style: TextStyles.ruberoidLight18,
                          ),
                        ),
                      if (url.isNotEmpty) ...{
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            debugPrint('link pushed');
                            if (Platform.isAndroid) {
                              _showDialog(url);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: AppTheme.mainElementColor,
                            ),
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 15),
                            height: MediaQuery.of(context).size.height * 0.08,
                            constraints: const BoxConstraints(minHeight: 60),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.link,
                                      color: Colors.white54,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Text(
                                        url,
                                        style: TextStyles.ruberoidLight16,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      },
                      if (answers != null && question.isNotEmpty) ...{
                        Column(
                          children: [
                            const SizedBox(height: 40),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 450),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 450),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: answers.length,
                                    itemBuilder: (context, index) {
                                      bool isLastIndex =
                                          index == answers.length - 1;
                                      return Column(
                                        children: [
                                          Container(
                                            constraints: const BoxConstraints(
                                                minHeight: 60),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 12),
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
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5, right: 5),
                                                    child: AutoSizeText(
                                                      answers[index].toString(),
                                                      style: TextStyles
                                                          .ruberoidLight18,
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
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
          if (entryField)
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    backgroundColor: AppTheme.mainColor,
                    context: context,
                    isScrollControlled: true,
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
            ),
        ],
      ),
    );
  }

  Widget buildBottomSheet(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: TextField(
                          autofocus: true,
                          controller: inputAnswer,
                          cursorHeight: 18,
                          decoration: const InputDecoration(
                            hintText: 'Введите ответ: ',
                            hintStyle: TextStyles.ruberoidLight20,
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                          ),
                          style: TextStyles.ruberoidLight16,
                          cursorColor: Colors.white,
                          maxLines: null,
                          minLines: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, bottom: 10, left: 20),
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
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog(String url) async {
    if (Platform.isAndroid) {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppTheme.mainColor,
            surfaceTintColor: Colors.transparent,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    url,
                    textAlign: TextAlign.center,
                    style: TextStyles.ruberoidLight16,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: const Text('Нет', style: TextStyles.ruberoidRegular20),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Да',
                      style: TextStyles.ruberoidLight16,
                    ),
                    onPressed: () {
                      debugPrint('url confirmed');
                      Navigator.pop(context);
                      openWebView(url);
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
    if (Platform.isIOS) {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          content: Text(
            url,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                isDefaultAction: true,
                child: const Text(
                  'Нет',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                )),
            CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  debugPrint('url confirmed');
                  Navigator.pop(context);
                  openWebView(url);
                },
                child: const Text(
                  'Да',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ))
          ],
        ),
      );
    }
  }

  Future<void> openWebView(String url) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebviewPage(
          link: url,
        ),
      ),
    );
  }
}

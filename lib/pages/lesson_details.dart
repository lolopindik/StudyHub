// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/lessons_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class LessonDetails extends StatelessWidget {
  final Map<String, dynamic> lessonData;

  const LessonDetails({required this.lessonData, super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> documents = lessonData['documents']?.values.toList() ?? [];

    return Scaffold(
      appBar: buildLessonAppBar(context),
      backgroundColor: AppTheme.secondaryColor,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.103,
            color: AppTheme.mainElementColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Text(
                      lessonData['name'] ?? 'Lesson',
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
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            const Icon(Icons.description, color: Colors.white54,),
                            const SizedBox(width: 10,),
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
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';

class LessonDetails extends StatelessWidget {
  final Map<String, dynamic> lessonData;

  const LessonDetails({super.key, required this.lessonData});

  @override
  Widget build(BuildContext context) {
    List<dynamic> documents = lessonData['documents']?.values.toList() ?? [];

    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          lessonData['name'] ?? 'Lesson',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppTheme.mainColor,
      ),
      body: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          final String documentUrl = documents[index] as String;
          return ListTile(
            title: Text(documentUrl),
            onTap: () {
              //TODO: добавить рабочие ссылки
            },
          );
        },
      ),
    );
  }
}

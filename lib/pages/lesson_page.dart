import 'package:flutter/material.dart';

class LessonPage extends StatelessWidget {
  final Map<String, dynamic> lessonData;

  const LessonPage({super.key, required this.lessonData});

  @override
  Widget build(BuildContext context) {
    List<dynamic> lessons = lessonData['lessons'] ?? []; //получение списка уроков

    return Scaffold(
      appBar: AppBar(
        title: Text(lessonData['name'] ?? 'Lesson'),
      ),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> lesson = lessons[index];
          return ListTile(
            title: Text(lesson['name'] ?? 'Lesson ${index + 1}'),
            onTap: () {},
          );
        },
      ),
    );
  }
}

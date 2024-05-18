import 'package:flutter/material.dart';
import 'package:study_hub/pages/lesson_details.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/lessons_appbar.dart';

class LessonPage extends StatelessWidget {
  final Map<String, dynamic> lessonData;

  const LessonPage({super.key, required this.lessonData});

  @override
  Widget build(BuildContext context) {
    List<dynamic> lessons = lessonData['lessons'] ?? [];
    debugPrint('проверка LessonPage: $lessons');

    return Scaffold(
      appBar: buildLessonAppBar(context),
      backgroundColor: AppTheme.secondaryColor,
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.103,
            color: AppTheme.mainElementColor,
            constraints: const BoxConstraints(minHeight: 60,),
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
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> lesson = lessons[index];
                int lessonComplete = lesson['lessonComplete'] ?? 0;
                BoxDecoration containerDecoration =
                    _getGradientDecorationForLessonComplete(lessonComplete);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonDetails(lessonData: lesson),
                      ),
                    );
                  },
                  child: Container(
                    width: 10,
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                    decoration: containerDecoration,
                    constraints: const BoxConstraints(minHeight: 60),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          lesson['name'] ?? 'Lesson ${index + 1}',
                          style: TextStyles.ruberoidLight20,
                          overflow: TextOverflow.ellipsis,
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

  BoxDecoration _getGradientDecorationForLessonComplete(int lessonComplete) {
    List<Color> colors;
    switch (lessonComplete) {
      case 1:
        colors = [AppTheme.mainColor, AppTheme.lessonCompleteRed];
        break;
      case 2:
        colors = [AppTheme.mainColor, AppTheme.lessonCompleteGreen];
        break;
      case 3:
        colors = [AppTheme.mainColor, AppTheme.lessonCompleteYellow];
        break;
      default:
        colors = [AppTheme.mainElementColor, AppTheme.mainElementColor];
    }
    return BoxDecoration(
      borderRadius: BorderRadius.circular(60),
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    );
  }
}

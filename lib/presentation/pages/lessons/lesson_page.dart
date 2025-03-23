import 'package:flutter/material.dart';
import 'package:study_hub/presentation/pages/lessons/lesson_details.dart';
import 'package:study_hub/logic/config/theme/app_theme.dart';
import 'package:study_hub/presentation/widgets/appbars/lessons_appbar.dart';
import 'package:auto_size_text/auto_size_text.dart';

class LessonPage extends StatefulWidget {
  final Map<String, dynamic> lessonData;
  final VoidCallback refreshData;

  const LessonPage(
      {super.key, required this.lessonData, required this.refreshData});

  @override
  State<LessonPage> createState() => LessonPageState();
}

class LessonPageState extends State<LessonPage> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> lessons = widget.lessonData['lessons'] ?? [];
    debugPrint('проверка LessonPage: $lessons');

    return Scaffold(
      appBar: buildLessonAppBar(context),
      backgroundColor: AppTheme.secondaryColor,
      body: Column(
        children: <Widget>[
          // Заголовок с названием курса
          Container(
            height: MediaQuery.of(context).size.height * 0.103,
            color: AppTheme.mainElementColor,
            constraints: const BoxConstraints(minHeight: 60),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return AutoSizeText(
                      widget.lessonData['name'] ?? 'Lesson',
                      style: TextStyles.ruberoidLight20,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          // Список уроков
          Expanded(
            child: ListView.builder(
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> lesson = lessons[index];
                int lessonProgress = lesson['progress'] ?? 0; // Прогресс урока
      
                // Получаем цвет для прогресса урока
                BoxDecoration containerDecoration =
                    _getGradientDecorationForLessonComplete(lessonProgress);
      
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonDetails(lessonData: lesson),
                      ),
                    ).then((value) {
                      if (value == true) {
                        setState(() {
                          widget.refreshData();
                          debugPrint('Data refreshed');
                        });
                      }
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                    decoration: containerDecoration,
                    constraints: const BoxConstraints(minHeight: 60),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: AutoSizeText(
                          lesson['name'] ?? 'Lesson ${index + 1}',
                          style: TextStyles.ruberoidLight20,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Функция для получения градиентной заливки в зависимости от состояния прогресса урока
  BoxDecoration _getGradientDecorationForLessonComplete(int lessonProgress) {
    List<Color> colors;
    switch (lessonProgress) {
      case 1: // Урок выполнен неправильно
        colors = [AppTheme.mainColor, AppTheme.lessonCompleteRed];
        break;
      case 3: // Урок выполнен правильно
        colors = [AppTheme.mainColor, AppTheme.lessonCompleteGreen];
        break;
      case 2: // Урок ожидает проверки
        colors = [AppTheme.mainColor, AppTheme.lessonCompleteYellow];
        break;
      default: // Урок не выполнен
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
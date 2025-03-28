import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:study_hub/logic/backend/fire_funcs.dart';
import 'package:study_hub/presentation/pages/lessons/lesson_page.dart';
import 'package:study_hub/presentation/pages/settings/settings.dart';
import 'package:study_hub/logic/config/theme/app_theme.dart';
import 'package:study_hub/presentation/widgets/elements/empty_container.dart';
import 'package:study_hub/presentation/widgets/elements/loading/cupertinoLoadingIndicator.dart';
import 'package:study_hub/presentation/widgets/elements/loading/customLoadingIndicator.dart';
import 'package:study_hub/presentation/widgets/elements/blur_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String? _userId;
  late Future<List<Map<String, dynamic>>> _futureCoursesData;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
        _futureCoursesData = compareTokens(_userId);
      });
    }
  }

  Future<void> refreshData() async {
    setState(() {
      _futureCoursesData = compareTokens(_userId);
      compareTokens(_userId);
    });
  }

  Future<void> navigateToSettings() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserSettings()),
    );

    if (result == true) {
      refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildHomeAppBar(context),
      backgroundColor: AppTheme.mainColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: BlurContainer(
              blurColor: const Color.fromARGB(255, 92, 91, 91),
              child: Container(),
            ),
          ),
          _buildContent(),
        ],
      ),
    );
  }

  PreferredSizeWidget? buildHomeAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: AppTheme.mainColor,
      title: const Text(
        'StudyHub',
        style: TextStyles.ruberoidRegular28,
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.secondaryColor,
            ),
            child: IconButton(
              onPressed: () {
                navigateToSettings();
              },
              icon: const Icon(
                Icons.tune,
                size: 23,
                color: Colors.grey,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContent() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _futureCoursesData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          if (Platform.isIOS) {
            return const CupertinoTransparentIndicator();
          } else {
            return const CustomTransparentLoadingIndicator();
          }
        } else if (snapshot.hasError) {
          debugPrint('Error: ${snapshot.error}');
          return buildEmptyContaine('Данные курса отсутствуют', context);
        } else {
          final List<Map<String, dynamic>>? coursesData = snapshot.data;
          if (coursesData == null || coursesData.isEmpty) {
            return buildEmptyContaine('Данные курса отсутствуют', context);
          } else {
            return Column(
              children: [
                _buildRefreshableHeader(context, coursesData),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                      color: AppTheme.secondaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: _buildCourseList(coursesData),
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }

  Widget _buildRefreshableHeader(
      BuildContext context, List<Map<String, dynamic>> coursesData) {
    return RefreshIndicator(
      onRefresh: refreshData,
      color: Colors.white70,
      backgroundColor: AppTheme.signElementColor,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.4,
            child: _buildPiechart(context, coursesData)),
      ),
    );
  }

  Widget _buildPiechart(BuildContext context, List<Map<String, dynamic>> coursesData) {
    return PieChart(
      PieChartData(
        centerSpaceRadius: MediaQuery.of(context).size.height * 0.07,
        sections: getSections(coursesData),
      ),
    );
  }

  Widget _buildCourseList(List<Map<String, dynamic>> coursesData) {
    return ListView.builder(
      itemCount: coursesData.length,
      itemBuilder: (context, index) {
        final Map<String, dynamic> courseData = coursesData[index];
        final List<Map<String, dynamic>> subjects =
            courseData['subjects'] ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> subjectDetails = subjects[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonPage(
                          lessonData: subjectDetails,
                          refreshData: refreshData, 
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppTheme.mainElementColor,
                      ),
                      constraints: const BoxConstraints(minHeight: 60),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            subjectDetails['name'] ?? 'Subject Name',
                            style: TextStyles.ruberoidLight20,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  List<PieChartSectionData> getSections(
    List<Map<String, dynamic>> coursesData) {
    List<PieChartSectionData> sections = [];
    int totalLessons = 0;
    int completedLessons = 0;

    // Проходим по всем курсам и урокам
    for (var courseData in coursesData) {
      final List<Map<String, dynamic>> subjects = courseData['subjects'] ?? [];
      for (var subject in subjects) {
        final List<Map<String, dynamic>> lessons = subject['lessons'] ?? [];
        for (var lesson in lessons) {
          totalLessons++;
          // Проверяем прогресс каждого урока
          if (lesson['progress'] == 3) { // Если урок завершен корректно
            completedLessons++;
          }
        }
      }
    }

    // Рассчитываем процент завершения
    double progress = totalLessons > 0 ? (completedLessons / totalLessons) * 100 : 0;

    // Добавляем секции диаграммы
    sections.add(
      PieChartSectionData(
        color: AppTheme.lessonCompleteGreen,
        value: progress,
        title: '${progress.toStringAsFixed(1)}%',
        titleStyle: TextStyles.ruberoidRegular20,
        radius: MediaQuery.of(context).size.height * 0.1,
      ),
    );
    sections.add(
      PieChartSectionData(
        color: AppTheme.mainColor,
        value: 100 - progress,
        title: '',
        radius: MediaQuery.of(context).size.height * 0.08,
      ),
    );

    return sections;
  }
}

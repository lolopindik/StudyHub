import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/CustomLoadingIndicator.dart';
import 'package:study_hub/widgets/home_appbar.dart';
import 'package:study_hub/fire_funcs.dart';
import 'package:study_hub/pages/lesson_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String? _userId;

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
      });
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
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: compareTokens(_userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomTransparentLoadingIndicator());
        } else if (snapshot.hasError) {
          debugPrint('Error: ${snapshot.error}');
          return _buildNoCoursesContainer();
        } else {
          final List<Map<String, dynamic>> coursesData = snapshot.data ?? [];
          if (coursesData.isEmpty) {
            return _buildNoCoursesContainer();
          } else {
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: PieChart(
                      PieChartData(
                        centerSpaceRadius:
                            MediaQuery.of(context).size.height * 0.07,
                        sections: getSections(coursesData),
                      ),
                    ),
                  ),
                ),
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

  Widget _buildNoCoursesContainer() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: AppTheme.mainColor,
          borderRadius: BorderRadius.circular(40)
        ),
        child: const Padding(
          padding:EdgeInsetsDirectional.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              'Данные курса отсутствуют',
              style: TextStyles.ruberoidLight20,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
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
                return Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LessonPage(
                            lessonData: subjectDetails,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            height: MediaQuery.of(context).size.height * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: AppTheme.mainElementColor,
                            ),
                            // ignore: sort_child_properties_last
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Text(
                                  subjectDetails['name'] ?? 'Subject Name',
                                  style: TextStyles.ruberoidLight20,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            constraints: const BoxConstraints(minHeight: 60),
                          ),
                        ),
                      ],
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
    for (var courseData in coursesData) {
      final List<Map<String, dynamic>> subjects = courseData['subjects'] ?? [];
      for (var subject in subjects) {
        final List<Map<String, dynamic>> lessons = subject['lessons'] ?? [];
        for (var lesson in lessons) {
          totalLessons++;
          if (lesson['lessonComplete'] == 2) {
            completedLessons++;
          }
        }
      }
    }

    double progress = (completedLessons / totalLessons) * 100;
    sections.add(
      PieChartSectionData(
        color: const Color.fromARGB(227, 77, 167, 69),
        value: progress,
        title: '',
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

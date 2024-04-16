import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/CustomLoadingIndicator.dart';
import 'package:study_hub/widgets/home_appbar.dart';
import 'package:study_hub/fire_funcs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: const BoxDecoration(
                color: AppTheme.secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: compareTokens(_userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CustomLoadingIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final List<Map<String, dynamic>> coursesData =
                        snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: coursesData.length,
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> courseData =
                            coursesData[index];
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
                                final Map<String, dynamic> subjectDetails =
                                    subjects[index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.95,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            color: AppTheme.mainElementColor,
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Text(
                                                subjectDetails['name'] ??
                                                    'Subject Name',
                                                style:
                                                    TextStyles.ruberoidLight20,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Container(
              height: 230,
              padding: const EdgeInsets.all(20),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: compareTokens(_userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CustomTransparentLoadingIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final List<Map<String, dynamic>> coursesData =
                        snapshot.data ?? [];
                    return PieChart(
                      PieChartData(
                        centerSpaceRadius: 50,
                        sections: getSections(coursesData),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
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
        color: const Color.fromARGB(255, 14, 207, 123),
        value: progress,
        title: '',
        radius: 50,
      ),
    );
    sections.add(
      PieChartSectionData(
        color: AppTheme.mainColor,
        value: 100 - progress,
        title: '',
        radius: 50,
      ),
    );

    return sections;
  }
}

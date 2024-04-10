import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/widgets/home_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseReference userRef;
  String? _userId;
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? _courseData;

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
        userRef = FirebaseDatabase.instance.ref().child("UserDetails").child(_userId!);
      });
      DataSnapshot snapshot = await userRef.get();
      setState(() {
        _userData = snapshot.value as Map<String, dynamic>?; 
      });
      _fetchCourseDetails();
    }
  }

  void _fetchCourseDetails() async {
    if (_userData != null && _userData!['courseProgress'] != null) {
      String courseToken = _userData!['courseProgress']['courseToken'];
      DatabaseReference courseRef = FirebaseDatabase.instance.ref().child("Courses").child(courseToken);
      DataSnapshot snapshot = await courseRef.get();
      setState(() {
        _courseData = snapshot.value as Map<String, dynamic>?; 
      });
      // Here you can proceed with any further actions with user and course data
      // For example, you can track the user's progress in the course
      _trackUserProgress();
    }
  }

  void _trackUserProgress() {
    // Implement your logic for tracking user progress here
    // For example, you can check which lessons the user has completed
    // based on the data retrieved from _userData and _courseData
    // Update UI or perform any other actions accordingly
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildHomeAppBar(context),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

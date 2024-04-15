// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:study_hub/fire%D0%B0func.dart';
import 'package:study_hub/pages/home_page.dart';
import 'package:study_hub/pages/sign_up_in.dart';
import 'package:study_hub/pages/user_details.dart';
import 'package:study_hub/pages/welcome_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseService firebaseService = FirebaseService();

  final connectedRef = FirebaseDatabase.instance.ref(".info/connected");
  connectedRef.onValue.listen((event) {
    final connected = event.snapshot.value as bool? ?? false;
    if (connected) {
      debugPrint("Dataabse: Connected.");
    } else {
      debugPrint("Dataabse: Not connected.");
    }
  });

  firebaseService.onListenUser((user) async {
    bool isFirstLaunch = await firebaseService.isFirstLaunch();

    Widget initialPage;

    if (user == null) {
      if (isFirstLaunch) {
        await firebaseService.setFirstLaunch(false);
        initialPage = const WelcomePage();
        print('first launch, no user');
      } else {
        initialPage = const SignUpInPage();
        print('no user');
      }
    } else {
      final ref = FirebaseDatabase.instance.ref();
      final tokenSnapshot = await ref
          .child('UserDetails/${user.uid}/courseProgress/courseToken')
          .get();
      if (tokenSnapshot.value != null) {
        print('Токен курса: ${tokenSnapshot.value}');
        print('user $user');
        initialPage = const HomePage();
      } else {
        print('no token');
        initialPage = const UserData();
      }
    }

    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: initialPage,
    ));
  });
}

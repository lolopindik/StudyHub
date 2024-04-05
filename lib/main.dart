// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:study_hub/fireauth.dart';
import 'package:study_hub/pages/home_page.dart';
import 'package:study_hub/pages/sign_up_in.dart';
import 'package:study_hub/pages/welcome_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseService firebaseService = FirebaseService();

  firebaseService.onListenUser((user) async {
    bool isFirstLaunch = await firebaseService.isFirstLaunch();

    Widget initialPage;

    if (user == null) {
      if (isFirstLaunch) {
        await firebaseService.setFirstLaunch(false);
        initialPage = const WelcomePage();
        print('no user');
      } else {
        initialPage = const SignUpInPage();
        print('no user');
      }
    } else {
      initialPage = const HomePage();
      print('user $user');
    }

    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: initialPage,
    ));
  });
}
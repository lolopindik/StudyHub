import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:study_hub/fire_funcs.dart';
import 'package:study_hub/pages/home_page.dart';
import 'package:study_hub/pages/sign_up_in.dart';
import 'package:study_hub/pages/user_details.dart';
import 'package:study_hub/pages/welcome_page.dart';
import 'package:study_hub/preferences/app_theme.dart';
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
        debugPrint('first launch, no user');
      } else {
        initialPage = const SignUpInPage();
        debugPrint('no user');
      }
    } else {
      final ref = FirebaseDatabase.instance.ref();
      final tokenSnapshot = await ref
          .child('UserDetails/${user.uid}/courseProgress/courseToken')
          .get();
      if (tokenSnapshot.value != null) {
        debugPrint('Токен курса: ${tokenSnapshot.value}');
        debugPrint('user $user');
        initialPage = const HomePage();
      } else {
        debugPrint('no token');
        initialPage = const UserData();
      }
    }

    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white70, 
          selectionColor: AppTheme.secondaryColor, 
          selectionHandleColor: Colors.white70 
        ),
      ),
      home: initialPage,
    ));
  });
}

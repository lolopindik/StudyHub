import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:study_hub/pages/home_page.dart';
import 'package:study_hub/widgets/sign_appbar.dart';
import 'package:study_hub/widgets/user_form.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final fullnameController = TextEditingController();
  final tokenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSignAppBar(context),
      body: UserDataForm(
        fullnameController: fullnameController,
        tokenController: tokenController,
        sendDataToFirebase: sendDataToFirebase,
        navigateToHomepage: navigateToHomepage,
      ),
    );
  }

  void sendDataToFirebase() {
    String fullname = fullnameController.text;
    String courseToken = tokenController.text;

    if (fullname.isNotEmpty && courseToken.isNotEmpty) {
      Map<String, dynamic> userData = {
        'fullname': fullname,
        'courseToken': courseToken,
      };

      DatabaseReference userDetailsRef =
          FirebaseDatabase.instance.ref().child('UserDetails');
      userDetailsRef.push().set(userData).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Данные успешно отправлены'),
          ),
        );
        navigateToHomepage();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Не удалось отправить данные: $error'),
            duration: const Duration(seconds: 2),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Поля пусты'),
        ),
      );
    }
  }

  void navigateToHomepage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }
}


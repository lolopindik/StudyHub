import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:study_hub/pages/home_page.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/sign_appbar.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final fullnameController = TextEditingController();
  final tokenController = TextEditingController();

  @override
  Widget build(context) {
    FirebaseDatabase.instance.ref().child('UserDetails');
    return Scaffold(
      appBar: buildSignAppBar(context),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 340,
                  width: 319,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppTheme.secondaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Данные',
                          style: TextStyles.ruberoidLight32,
                        ),
                      ),
                      Container(
                        height: 264,
                        width: 319,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: AppTheme.mainColor,
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                width: 282,
                                height: 51,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: AppTheme.signElementColor,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 5),
                                  child: TextField(
                                    controller: fullnameController,
                                    style: TextStyles.ruberoidLight16,
                                    decoration: const InputDecoration(
                                      hintText: 'Full name:',
                                      hintStyle: TextStyles.ruberoidLight20,
                                      border: InputBorder.none,
                                    ),
                                    cursorColor: Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                width: 282,
                                height: 51,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: AppTheme.signElementColor,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 5),
                                  child: TextField(
                                    obscureText: true,
                                    controller: tokenController,
                                    style: TextStyles.ruberoidLight16,
                                    decoration: const InputDecoration(
                                      hintText: 'Course token:',
                                      hintStyle: TextStyles.ruberoidLight20,
                                      border: InputBorder.none,
                                    ),
                                    cursorColor: Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 61),
                              child: InkWell(
                                onTap: () {
                                  sendDataToFirebase();
                                },
                                child: Container(
                                  width: 282,
                                  height: 51,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    color: AppTheme.secondaryColor,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Подтвердить',
                                      style: TextStyles.ruberoidLight20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
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

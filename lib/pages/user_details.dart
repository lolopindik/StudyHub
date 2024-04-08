// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/sign_appbar.dart';

class UserData extends StatefulWidget {
  UserData({super.key});
  final fullnameController = TextEditingController();
  final tokenController = TextEditingController();
  String messageFire = ' ';
 
  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(context) {
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
                                    controller: widget.fullnameController,
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
                                    controller: widget.tokenController,
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
                                //TODO: Отправить данные на субд
                                onTap: () {},
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
}

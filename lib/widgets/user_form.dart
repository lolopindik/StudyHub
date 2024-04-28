import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/CustomLoadingIndicator.dart';

class UserDataForm extends StatelessWidget {
  final TextEditingController fullnameController;
  final TextEditingController tokenController;
  final Function sendDataToFirebase;
  final Function navigateToHomepage;
  final List<String> courses;
  final String? selectedCourse;
  final Function(String?) onCourseChanged;

  const UserDataForm({
    super.key,
    required this.fullnameController,
    required this.tokenController,
    required this.sendDataToFirebase,
    required this.navigateToHomepage,
    required this.courses,
    this.selectedCourse, // Nullable selectedCourse
    required this.onCourseChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const CustomLoadingIndicator(),
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
                                child: DropdownButton<String>(
                                  value: selectedCourse,
                                  onChanged: onCourseChanged,
                                  dropdownColor: AppTheme.mainColor,
                                  iconEnabledColor: Colors.white54,
                                  items: courses.map((String course) {
                                    return DropdownMenuItem<String>(
                                      value: course,
                                      child: Text(
                                        course,
                                        style: TextStyles.ruberoidLight16,
                                      ),
                                    );
                                  }).toList(),
                                  underline: Container(),
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
    );
  }
}

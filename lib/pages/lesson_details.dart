// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/lessons_appbar.dart';

class LessonDetails extends StatefulWidget {
  final Map<String, dynamic> lessonData;

  const LessonDetails({super.key, required this.lessonData});

  @override
  _LessonDetailsState createState() => _LessonDetailsState();
}

class _LessonDetailsState extends State<LessonDetails> {
  TextEditingController inputAnswer = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> materials = widget.lessonData['materials']?.values.toList() ?? [];
    //todo данные передаются не полностью надо как-то фиксить
    debugPrint('materials: $materials'); //! почемуто-то отличается от widget.lessonData
    debugPrint('lessonData: ${widget.lessonData}');
    return Scaffold(
      appBar: buildLessonAppBar(context),
      backgroundColor: AppTheme.secondaryColor,
      body: RawScrollbar(
        thumbColor: Colors.white70,
        thickness:2,
        radius: const Radius.circular(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.103,
                color: AppTheme.mainElementColor,
                constraints: const BoxConstraints(minHeight: 60),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Text(
                          widget.lessonData['name'] ?? 'Lesson',
                          style: constraints.maxWidth > 150
                              ? TextStyles.ruberoidRegular20
                              : TextStyles.ruberoidRegular28,
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('$materials', style: TextStyles.ruberoidLight16,),
                //child: Text('${widget.lessonData['materials']}, style: TextStyles.ruberoidLight16,),
              ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: materials.length,
              //     itemBuilder: (context, index) {
              //       Map<String, dynamic> materialContent = materials[index];
              //       debugPrint('Информация в materials: $materialContent');
              //       if (materialContent.containsKey('theory')) {
              //         return Align(
              //           alignment: Alignment.centerLeft,
              //           child: Padding(
              //             padding: const EdgeInsets.only(
              //                 left: 15, right: 15, top: 20, bottom: 20),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   materialContent['theory'],
              //                   style: TextStyles.ruberoidLight20,
              //                   textAlign: TextAlign.left,
              //                   overflow: TextOverflow.clip,
              //                 ),
              //               ],
              //             ),
              //           ),
              //         );
              //       } else {
              //         return Container();
              //       }
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

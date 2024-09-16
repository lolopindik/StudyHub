import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';

Widget buildBottomSheet(BuildContext context, TextEditingController inputAnswer, Function submitAnswer) {
  return Padding(
    padding: MediaQuery.of(context).viewInsets,
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.3,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: TextField(
                        autofocus: true,
                        controller: inputAnswer,
                        cursorHeight: 18,
                        decoration: const InputDecoration(
                          hintText: 'Введите ответ: ',
                          hintStyle: TextStyles.ruberoidLight20,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                        ),
                        style: TextStyles.ruberoidLight16,
                        cursorColor: Colors.white,
                        maxLines: null,
                        minLines: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 10, left: 20),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.secondaryColor,
                    ),
                    child: IconButton(
                      onPressed: () {
                        submitAnswer();
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

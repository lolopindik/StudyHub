import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';
import 'package:study_hub/widgets/elements/details/bottomsheet.dart';

Widget buildEntryField(
    BuildContext context, TextEditingController inputAnswer) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
          backgroundColor: AppTheme.mainColor,
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return buildBottomSheet(context, inputAnswer);
          },
        );
      },
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.1,
        constraints: const BoxConstraints(minHeight: 80),
        decoration: const BoxDecoration(
          color: AppTheme.mainColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Введите ответ: ',
                  style: TextStyles.ruberoidRegular20,
                ),
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.secondaryColor,
                  ),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:study_hub/preferences/app_theme.dart';

PreferredSizeWidget? buildSignAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppTheme.mainColor,
    title: const Text(
      'StudyHub',
      style: TextStyles.ruberoidRegular28,
    ),
    centerTitle: true,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.secondaryColor,
            ),
            child: IconButton(
                onPressed: /*перевод на страницу настроек*/ () {},
                icon: const Icon(
                  Icons.tune,
                  size: 23,
                ))),
      )
    ],
  );
}

Widget buildSignBottomBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 210,
        height: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: AppTheme.mainColor
          ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>
            [
              IconButton(onPressed: (){}, icon: const Icon(Icons.person_add_alt, size: 45,)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.person_outline_outlined,  size: 45)),
            ],
          ),
        ),
      ),
    ),
  );
}

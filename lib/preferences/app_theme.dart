import 'package:flutter/material.dart';

class AppTheme {
  static const Color mainColor = Color.fromARGB(255, 43, 40, 40); //2B2828
  static const Color secondaryColor = Color.fromARGB(255, 27, 27, 27); //1B1B1B
  static const Color signElementColor = Color.fromARGB(83, 27, 27, 27); //! цвет не совпадает с макетом
  static const Color mainElementColor = Color.fromARGB(120, 43, 40, 40); //! цвет не совпадает с макетом
  static const Color lessonCompleteGreen = Color.fromARGB(150, 77, 167, 69);
  static const Color lessonCompleteRed = Color.fromARGB(150, 167, 69, 69);
  static const Color lessonCompleteYellow = Color.fromARGB(255, 167, 164, 69);
}

class TextStyles {
  static const TextStyle ruberoidLight16 = TextStyle(fontFamily: 'Ruberoid-Light', fontSize: 16, color: Colors.white, );
  static const TextStyle ruberoidLight20 = TextStyle(fontFamily: 'Ruberoid-Light', fontSize: 20, color: Colors.white, );
  static const TextStyle ruberoidLight28 = TextStyle(fontFamily: 'Ruberoid-Light', fontSize: 28, color: Colors.white, );
  static const TextStyle ruberoidLight32 = TextStyle(fontFamily: 'Ruberoid-Light', fontSize: 32, color: Colors.white, );

  static const TextStyle ruberoidRegular20 = TextStyle(fontFamily: 'Ruberoid-Regular', fontSize: 20, color: Colors.white, );
  static const TextStyle ruberoidRegular28 = TextStyle(fontFamily: 'Ruberoid-Regular', fontSize: 28, color: Colors.white, );
  static const TextStyle ruberoidRegular40 = TextStyle(fontFamily: 'Ruberoid-Regular', fontSize: 40, color: Colors.white, );
}
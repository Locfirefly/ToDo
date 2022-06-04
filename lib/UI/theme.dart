
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
const Color background = Color(0xffDED6EE);
const Color bluishClr = Color(0xff8151E2);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color whiteClr = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = Color(0xFF424242);

class Themes{
  static final light= ThemeData(
    backgroundColor: whiteClr,
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
  backgroundColor: whiteClr,
  ),
  );

  static final dark=  ThemeData(
    backgroundColor: darkGreyClr,
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
  backgroundColor: darkGreyClr,
  ),
  );
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle:  TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey
    )
  );
}
TextStyle get headingStyle{
  return GoogleFonts.lato(
      textStyle:  TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : Colors.black
      )
  );
}
TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.grey[400] : Colors.black
      )
  );
}
  TextStyle get subtitleStyle{
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400],
        )
    );
}
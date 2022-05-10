import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme{
  static ThemeData get darkTheme{
    return ThemeData(
      scaffoldBackgroundColor: CustomColors.gray,
      primaryColor: Colors.white,
      appBarTheme: AppBarTheme(backgroundColor: CustomColors.white,elevation: 0),
      textTheme: TextTheme(
        bodyText1: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12)),
        bodyText2: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12)),
        headline1: GoogleFonts.lato(textStyle: const TextStyle()),
        headline2: GoogleFonts.lato(textStyle: const TextStyle()),
        headline3: GoogleFonts.lato(textStyle: const TextStyle()),
        headline4: GoogleFonts.lato(textStyle: const TextStyle()),
        headline5: GoogleFonts.lato(textStyle: const TextStyle()),
        headline6: GoogleFonts.lato(textStyle: const TextStyle()),
        subtitle1: GoogleFonts.lato(textStyle: const TextStyle()),
        subtitle2: GoogleFonts.lato(textStyle: const TextStyle()),
        caption: GoogleFonts.lato(textStyle: const TextStyle()),
        button: GoogleFonts.lato(textStyle: const TextStyle()),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        buttonColor: Colors.blue
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(backgroundColor: CustomColors.white,primary: CustomColors.primary,onSurface: CustomColors.primary)
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.lightGreen
      ),bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: CustomColors.white,
      )

    );
  }
}

class CustomColors{
  static var gradient = LinearGradient(colors: [purple,primary]);
  static var primary = const Color.fromRGBO(5,78,189,1);
  static Color dark = const Color.fromRGBO(27, 34, 46, 1);
  static Color purple = const Color.fromRGBO(110, 82, 252 , 1);
  static Color gray = const Color(0XFFF7F7F7);
  static Color green = const Color(0XFF00FF00);
  static Color someGray = const Color.fromRGBO(89, 106, 131, 1);
  static Color white = const Color.fromRGBO(255, 255, 255, 1);
  static Color red = const Color.fromRGBO(255, 0, 0, 1);

}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
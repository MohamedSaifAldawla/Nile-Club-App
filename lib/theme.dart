import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nile_club/Globals/globals.dart';

const kPrimaryColor = Color(0xFF03A9F5);
const kPrimary2Color = Color(0xFF2482C5);
const kPrimaryLightColor = Colors.white;
const kPrimaryDarkColor = Color(0xFF15141F);
const kPrimaryDark2Color = Color(0xff001226);
const kPrimaryDark3Color = Color(0xff191825);
const kSecondaryColor = Color.fromARGB(255, 134, 134, 134);
const kTextColor = Color.fromARGB(255, 62, 62, 62);
const Color navyBlue1 = Color.fromARGB(150, 3, 169, 245);
const Color yellow = Color(0xfffbbd5c);
const Color yellow2 = Color.fromARGB(150, 251, 189, 92);
const Color gold = Color(0xFFFDD802);
const Color purple = Color(0xFF360A80);
const Color orange = Color(0xffF77A47);
const Color platinum = Color(0xFFA0A0A0);
const Color shadow = Color.fromARGB(60, 170, 170, 170);
const Color shadow2 = Color.fromARGB(255, 25, 24, 37);
const Color success = Color(0xFF40C7A5);
const Color error = Color(0xFFE84C5C);
const boxShadow = BoxShadow(
  color: shadow,
  blurRadius: 10,
  offset: Offset(0, 2),
);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [kPrimaryColor, kPrimary2Color],
);
const kPrimaryGradientColor2 = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [yellow, yellow2],
);
const kSuccessGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF40C7A5), Color(0xFF21AD8B)],
);

const kErrorGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFE84C5C), Color(0xFFD82D3E)],
);

const kIndividualGradientColor = LinearGradient(
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
  colors: [kPrimary2Color, Color(0xff004EF8)],
);
const kfamailyGradientColor = LinearGradient(
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
  colors: [Color(0xFFf00851), Color(0xFF8c005f)],
);
const kAnimationDuration = Duration(milliseconds: 200);
const defaultDuration = Duration(milliseconds: 250);
double horizontalPadding = 20;

ThemeData theme({required String fontFamily}) {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: kPrimaryLightColor,
    fontFamily: lang == "ar" ? "Cairo" : "Roboto_Slab",
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: kPrimaryLightColor,
      foregroundColor: kTextColor,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: kSecondaryColor),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: kTextColor,
        height: 1.5,
      ),
      bodyText1: TextStyle(
        color: kTextColor,
      ),
      bodyText2: TextStyle(
        color: kTextColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: const TextStyle(fontSize: 19),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 19,
      ),
      fillColor: kPrimaryLightColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: kSecondaryColor),
        gapPadding: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: kPrimaryColor),
        gapPadding: 10,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: Colors.red),
        gapPadding: 10,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: Colors.red),
        gapPadding: 10,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

ThemeData themeDark({required String fontFamily}) {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kPrimaryDarkColor,
    fontFamily: lang == "ar" ? "Cairo" : "Roboto_Slab",
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: kPrimaryDarkColor,
      foregroundColor: kPrimaryLightColor,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: kPrimaryLightColor),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: kPrimaryLightColor,
        height: 1.5,
      ),
      bodyText1: TextStyle(
        color: kPrimaryLightColor,
      ),
      bodyText2: TextStyle(
        color: kPrimaryLightColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: const TextStyle(fontSize: 19),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 19,
      ),
      fillColor: kPrimaryDarkColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: kPrimaryLightColor),
        gapPadding: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: kPrimaryColor),
        gapPadding: 10,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: Colors.red),
        gapPadding: 10,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: Colors.red),
        gapPadding: 10,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

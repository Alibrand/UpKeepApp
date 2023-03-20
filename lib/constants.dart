import 'package:flutter/material.dart';

const Color kSplashColor = Color(0xff5a6b7b);
const Color kBotButtonColor = Color(0xffd1c8c1);
const Color kFemaleBackColor = Color(0xffe799a3);
const Color kMaleBackColor = Color(0xff659ec7);
const Color kFemaleButtonColor = Color(0xffa46a78);
const Color kMaleButtonColor = Color(0xff41627e);
const Color kBackgroundColor = kSplashColor;

const Color kPrimiaryColor = Colors.white;
const Color kHeadColor = Colors.white;
const Color kSecondaryColor = Color(0xff99a5b1);

//buttons colors
const Color kLoginButtonColor = Color(0xff659ec7);
const Color kCreateAccountButtonColor = Color(0xff41627e);

//error style
const TextStyle errorStyle = TextStyle(color: Colors.white);

const double sizedBoxHeight = 10.0;
const kGeneralPadding = 25.0;
const double kGeneralFontSize = 18;
const double kHeadFontSize = 20;
final kMainButtonStyle = ButtonStyle(
    padding:
        MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(15)),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff659ec7)),
    shape:
        MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    )));
final kSecButtonStyle = ButtonStyle(
    padding:
        MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(15)),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    backgroundColor: MaterialStateProperty.all<Color>(kSecondaryColor),
    shape:
        MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    )));
final kMaleButtonStyle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(vertical: 20, horizontal: 15)),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    backgroundColor: MaterialStateProperty.all<Color>(kMaleButtonColor),
    shape:
        MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    )));
final kFemMaleButtonStyle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(vertical: 20, horizontal: 15)),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    backgroundColor: MaterialStateProperty.all<Color>(kFemaleButtonColor),
    shape:
        MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    )));

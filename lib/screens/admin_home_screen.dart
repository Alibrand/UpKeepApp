import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upkeepapp/constants.dart';
import 'package:upkeepapp/controller/auth_controller.dart';
import 'package:upkeepapp/screens/admin_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  //Auth Controller
  final _authController = Get.find<AuthController>();

  late ButtonStyle buttonStyle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonStyle = _authController.currentUser.value.gender == "M"
        ? kMaleButtonStyle
        : kFemMaleButtonStyle;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: _authController.currentUser.value.gender == "M"
          ? kMaleBackColor
          : kFemaleBackColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              "Welcome Admin",
              style: TextStyle(
                  fontSize: kHeadFontSize,
                  color: kHeadColor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kGeneralPadding),
              child: TextButton(
                  style: buttonStyle,
                  onPressed: () => {Get.to(() => AdminScreen())},
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Manage Stations",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: kGeneralFontSize),
                    ),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kGeneralPadding),
              child: TextButton(
                  style: buttonStyle,
                  onPressed: () => _authController.userSignOut(),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Logout",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: kGeneralFontSize),
                    ),
                  )),
            ),
          ]),
    ));
  }
}

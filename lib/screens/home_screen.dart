import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upkeepapp/constants.dart';
import 'package:upkeepapp/controller/auth_controller.dart';

import 'bot_screen.dart';
import 'stations_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Obx(
                        () => Text(
                          "Welcome " +
                              _authController.currentUser.value.fullName,
                          style: TextStyle(
                              fontSize: kHeadFontSize,
                              color: kHeadColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text(
                        "Here are our services",
                        style: TextStyle(
                            fontSize: kGeneralFontSize,
                            color: kPrimiaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kGeneralPadding),
                        child: TextButton(
                            style: buttonStyle,
                            onPressed: () => {
                                  Get.to(() => StationsScreen(),
                                      arguments: "Wheels")
                                },
                            child: const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Wheels Repair",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: kGeneralFontSize),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kGeneralPadding),
                        child: TextButton(
                            style: buttonStyle,
                            onPressed: () => {
                                  Get.to(
                                    () => StationsScreen(),
                                    arguments: "Car Motor",
                                  )
                                },
                            child: const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Motor Repair",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: kGeneralFontSize),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kGeneralPadding),
                        child: TextButton(
                            style: buttonStyle,
                            onPressed: () => {
                                  Get.to(() => StationsScreen(),
                                      arguments: "Petrol")
                                },
                            child: const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Petrol Station",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: kGeneralFontSize),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kGeneralPadding),
                        child: TextButton(
                            style: buttonStyle,
                            onPressed: () => {
                                  Get.to(() => StationsScreen(),
                                      arguments: "Car Electricity")
                                },
                            child: const SizedBox(
                              width: double.infinity,

                              child: Text(
                                "Car Electrics Repair",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: kGeneralFontSize),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kGeneralPadding),
                        child: TextButton(
                            style: buttonStyle,
                            onPressed: () => {
                                  Get.to(() => StationsScreen(),
                                      arguments: "Winch")
                                },
                            child: const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Winch to lift your car",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: kGeneralFontSize),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kGeneralPadding),
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
                    ]))));
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Card(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Need some help?..."),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          FloatingActionButton(
            onPressed: () {
              Get.to(() => const BotChatScreen());
            },
            backgroundColor: kBotButtonColor,
            child: const Icon(Icons.chat),
          ),
        ],
      ),
    ));
  }
}

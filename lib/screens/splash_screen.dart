import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upkeepapp/constants.dart';

import '../controller/location_controller.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _locationControllller = Get.find<LocationController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _locationControllller.getCurrentUserLocation().then((_) {
      Timer(const Duration(seconds: 2),
          () => {Get.to(() => const LoginScreen())});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: kSplashColor,
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset("assets/images/splash.png")),
                const CircularProgressIndicator(
                  color: kSecondaryColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Finding Fine Location",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ))));
  }
}

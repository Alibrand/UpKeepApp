import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upkeepapp/controller/auth_controller.dart';
import 'package:upkeepapp/screens/station_info_screen.dart';

import '../constants.dart';
import '../controller/station_controller.dart';

class StationsScreen extends StatefulWidget {
  StationsScreen({Key? key}) : super(key: key);

  @override
  _StationsScreenState createState() => _StationsScreenState();
}

class _StationsScreenState extends State<StationsScreen> {
  //Auth Controller
  final _authController = Get.find<AuthController>();
  //Station Controller
  final _stationcontroller = Get.put(StationController());
  //get arguments
  var args = Get.arguments;
  //set type to wheels by default
  String stationType = "Wheels";

  late ButtonStyle buttonStyle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stationType = args;
    _stationcontroller.getStationsByType(stationType);
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
        body: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(stationType + " Stations",
                      style: const TextStyle(
                          fontSize: kHeadFontSize,
                          color: kHeadColor,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
                child: Obx(
              () => _stationcontroller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _stationcontroller.stationsList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(
                              _stationcontroller.stationsList[index].name,
                              style: const TextStyle(
                                  fontSize: kGeneralFontSize,
                                  fontWeight: FontWeight.bold)),
                          trailing: TextButton(
                            onPressed: () {
                              Get.to(() => const StationInfoScreen(),
                                  arguments: _stationcontroller
                                      .stationsList[index].id);
                            },
                            child: const Text(
                              "Contact",
                              style: const TextStyle(
                                  fontSize: kGeneralFontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: buttonStyle.copyWith(
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15)),
                            ),
                          ),
                        ),
                      ),
                    ),
            ))
          ],
        )),
      ),
    );
  }
}

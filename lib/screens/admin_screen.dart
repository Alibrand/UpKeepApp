import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upkeepapp/controller/auth_controller.dart';
import 'package:upkeepapp/screens/add_new_station.dart';

import '../constants.dart';
import '../controller/station_controller.dart';

class AdminScreen extends StatefulWidget {
  AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  //Auth Controller
  final _authController = Get.find<AuthController>();
  //Station Controller
  final _stationcontroller = Get.put(StationController());

  late ButtonStyle buttonStyle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _stationcontroller.getAllStations();
    buttonStyle = kMaleButtonStyle;
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
                  Text(" Stations",
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
                          leading: InkWell(
                            child: Icon(Icons.delete),
                            onTap: () {
                              // set up the buttons
                              Widget yesButton = Padding(
                                  padding: EdgeInsets.all(8),
                                  child: InkWell(
                                    child: Text("Yes"),
                                    onTap: () {
                                      Get.back();
                                      _stationcontroller
                                          .deleteStation(_stationcontroller
                                              .stationsList[index])
                                          .then((_) {
                                        _stationcontroller.getAllStations();
                                      });
                                    },
                                  ));
                              Widget noButton = Padding(
                                  padding: EdgeInsets.all(8),
                                  child: InkWell(
                                    child: Text("No"),
                                    onTap: () {
                                      Get.back();
                                    },
                                  ));

                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text("Confirm"),
                                content: Text("Sure to delete station?"),
                                actions: [
                                  yesButton,
                                  noButton,
                                ],
                              );
                              // show the dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            },
                          ),
                          title: Text(
                              _stationcontroller.stationsList[index].name,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              "Total Requests :" +
                                  _stationcontroller.stationsList[index].count
                                      .toString(),
                              style: const TextStyle(fontSize: 15)),
                          trailing: TextButton(
                            onPressed: () {},
                            child: Text(
                              _stationcontroller.stationsList[index].type,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed: () {
              Get.to(() => const AddNewStationScreen());
            },
            backgroundColor: kMaleButtonColor,
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

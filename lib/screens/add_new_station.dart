import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upkeepapp/controller/station_controller.dart';
import 'package:upkeepapp/model/Station.dart';

import '../constants.dart';

class AddNewStationScreen extends StatefulWidget {
  const AddNewStationScreen({Key? key}) : super(key: key);

  @override
  _AddNewStationScreenState createState() => _AddNewStationScreenState();
}

class _AddNewStationScreenState extends State<AddNewStationScreen> {
  //Auth Controller
  final _stationController = Get.find<StationController>();

  //TextEditing Controllers
  TextEditingController locationController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<String> stationTypes = [
    "Wheels",
    "Winch",
    "Car Motor",
    "Car Electricity",
    "Petrol"
  ];
  //

  String locationError = "",
      serviceError = "",
      costError = "",
      phoneError = "",
      nameError = "";

  bool isVisible = true;

  String selectedType = "Wheels";
  checkEmail() {
    setState(() {
      bool locationValid = RegExp(r"([0-9]+[.])+[0-9]+, *([0-9]+[.])+[0-9]+")
          .hasMatch(locationController.text);
      locationError = locationController.text.isNotEmpty
          ? locationValid
              ? ""
              : "Invalid location: should be like 34.6677,35.7888"
          : "This field is required";
    });
  }

  checkService() {
    setState(() {
      serviceError =
          serviceController.text.isEmpty ? "This field is required" : "";
    });
  }

  checkCost() {
    setState(() {
      bool costValid = RegExp(r"[0-9]+").hasMatch(costController.text);
      costError = costController.text.isNotEmpty
          ? costValid
              ? ""
              : "Only numbers are allowed"
          : "This field is required";
    });
  }

  checkPhone() {
    setState(() {
      bool phoneValid = RegExp(r"[0-9]+").hasMatch(phoneController.text);
      phoneError = phoneController.text.isNotEmpty
          ? phoneValid
              ? ""
              : "Only numbers are allowed"
          : "This field is required";
    });
  }

  checkName() {
    setState(() {
      bool nameValid = RegExp(r"^([^0-9]*)$").hasMatch(nameController.text);
      nameError = nameController.text.isEmpty
          ? "This field is required"
          : nameValid
              ? ""
              : "Only letters is allowed";
    });
  }

  //Function handles TextFields Validating
  bool validateForm() {
    bool check = true;
    checkEmail();
    checkName();
    checkService();
    checkPhone();

    bool empty = locationError.isNotEmpty ||
        serviceError.isNotEmpty ||
        phoneError.isNotEmpty ||
        nameError.isNotEmpty;
    if (empty) check = false;
    return check;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: kBackgroundColor,
            body: Center(child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                          child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Add Station",
                                  style: TextStyle(
                                      fontSize: kHeadFontSize,
                                      color: kPrimiaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Obx(() => _stationController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const SizedBox(
                                        width: 5,
                                      ))
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kGeneralPadding),
                              child: Focus(
                                onFocusChange: (focus) {
                                  if (!focus) checkName();
                                },
                                child: TextField(
                                  style: const TextStyle(
                                      fontSize: kGeneralFontSize),
                                  controller: nameController,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                      errorStyle: errorStyle.copyWith(
                                          color: Colors.red),
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorText:
                                          nameError.isEmpty ? null : nameError,
                                      contentPadding: EdgeInsets.zero,
                                      // icon: Icon(Icons.mail),
                                      prefixIcon: const Icon(Icons.text_fields),
                                      suffixIcon: nameController.text.isEmpty
                                          ? const Text('')
                                          : GestureDetector(
                                              onTap: () {
                                                nameController.clear();
                                              },
                                              child: const Icon(Icons.close)),
                                      labelText: 'Name',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 1))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: sizedBoxHeight,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kGeneralPadding),
                              child: Focus(
                                onFocusChange: (focus) {
                                  if (!focus) checkPhone();
                                },
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  style: const TextStyle(
                                      fontSize: kGeneralFontSize),
                                  controller: phoneController,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                      errorStyle: errorStyle.copyWith(
                                          color: Colors.red),
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorText: phoneError.isEmpty
                                          ? null
                                          : phoneError,
                                      contentPadding: EdgeInsets.zero,
                                      // icon: Icon(Icons.mail),
                                      prefixIcon:
                                          const Icon(Icons.phone_android),
                                      suffixIcon: phoneController.text.isEmpty
                                          ? const Text('')
                                          : GestureDetector(
                                              onTap: () {
                                                phoneController.clear();
                                              },
                                              child: const Icon(Icons.close)),
                                      labelText: 'Phone Number',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 1))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: sizedBoxHeight,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kGeneralPadding),
                              child: Focus(
                                onFocusChange: (focus) {
                                  if (!focus) checkService();
                                },
                                child: TextField(
                                  style: const TextStyle(
                                      fontSize: kGeneralFontSize),
                                  controller: serviceController,
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                      errorStyle: errorStyle.copyWith(
                                          color: Colors.red),
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorText: serviceError.isEmpty
                                          ? null
                                          : serviceError,
                                      contentPadding: EdgeInsets.zero,
                                      prefixIcon:
                                          const Icon(Icons.home_repair_service),
                                      hintText: 'Station Services',
                                      labelText: 'Services',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 1))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: sizedBoxHeight,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kGeneralPadding),
                              child: Focus(
                                onFocusChange: (focus) {
                                  if (!focus) checkCost();
                                },
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      fontSize: kGeneralFontSize),
                                  controller: costController,
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                      errorStyle: errorStyle.copyWith(
                                          color: Colors.red),
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorText:
                                          costError.isEmpty ? null : costError,
                                      contentPadding: EdgeInsets.zero,
                                      prefixIcon: const Icon(Icons.money),
                                      labelText: 'Service Cost',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 1))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: sizedBoxHeight,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kGeneralPadding),
                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.zero,
                                        hintText: "Station Type",
                                        prefixIcon:
                                            const Icon(Icons.car_repair),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                    isEmpty: selectedType.isEmpty,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: selectedType,
                                        isDense: true,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedType = newValue!;
                                            state.didChange(newValue);
                                          });
                                        },
                                        items: stationTypes.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kGeneralPadding),
                              child: Focus(
                                onFocusChange: (focus) {
                                  if (!focus) checkEmail();
                                },
                                child: TextField(
                                  style: const TextStyle(
                                      fontSize: kGeneralFontSize),
                                  controller: locationController,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                      errorStyle: errorStyle.copyWith(
                                          color: Colors.red),
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorText: locationError.isEmpty
                                          ? null
                                          : locationError,
                                      contentPadding: EdgeInsets.zero,
                                      // icon: Icon(Icons.mail),
                                      prefixIcon:
                                          const Icon(Icons.location_pin),
                                      suffixIcon: locationController
                                              .text.isEmpty
                                          ? const Text('')
                                          : GestureDetector(
                                              onTap: () {
                                                locationController.clear();
                                              },
                                              child: const Icon(Icons.close)),
                                      hintText: 'Location Coordinates',
                                      labelText: 'Location',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 1))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kGeneralPadding),
                              child: TextButton(
                                  style: kMainButtonStyle,
                                  onPressed: () async {
                                    if (!validateForm()) return;
                                    Station station = Station.empty();
                                    station.name = nameController.text;
                                    station.services = serviceController.text;
                                    station.phone = phoneController.text;
                                    station.cost =
                                        int.parse(costController.text);
                                    station.type = selectedType;
                                    String location = locationController.text;
                                    List<String> coordinates =
                                        location.split(',');
                                    double lat = double.parse(coordinates[0]);
                                    double lng = double.parse(coordinates[1]);
                                    GeoPoint point = GeoPoint(lat, lng);
                                    station.location = point;
                                    _stationController
                                        .addNewStation(station)
                                        .then((_) {
                                      _stationController.getAllStations();
                                      Get.back(closeOverlays: true);
                                    });
                                  },
                                  child: const SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Save",
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(fontSize: kGeneralFontSize),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ))));
            }))));
  }
}

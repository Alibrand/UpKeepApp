import "package:flutter/material.dart";
import "package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart";
import "package:get/get.dart";
import 'package:upkeepapp/constants.dart';
import 'package:upkeepapp/controller/auth_controller.dart';
import 'package:upkeepapp/controller/location_controller.dart';
import 'package:upkeepapp/controller/station_controller.dart';
import 'package:upkeepapp/model/Station.dart';
import "package:url_launcher/url_launcher.dart";

import 'payment_done_screen.dart';

class StationInfoScreen extends StatefulWidget {
  const StationInfoScreen({Key? key}) : super(key: key);

  @override
  State<StationInfoScreen> createState() => _StationInfoScreenState();
}

class _StationInfoScreenState extends State<StationInfoScreen> {
  //Auth Controller
  final _authController = Get.find<AuthController>();
  //Location controler to calculte distance
  final _locationController = Get.find<LocationController>();
  //Station Controller
  final _stationcontroller = Get.put(StationController());

  TextEditingController cardController = TextEditingController();
  TextEditingController expireController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  //get arguments
  var args = Get.arguments;
  String stationId = "";
  Station _station = Station.empty();
  int _distanceFromStation = 0;
  String _distanceUnit = " m";
  String cardError = "", expireError = "", cvvError = "";

  checkCard() {
    setState(() {
      cardError =
          cardController.text.isNotEmpty ? "" : "This field is required";
    });
  }

  checkExpire() {
    setState(() {
      expireError =
          expireController.text.isNotEmpty ? "" : "This field is required";
    });
  }

  checkCVV() {
    setState(() {
      cvvError = cvvController.text.isNotEmpty ? "" : "This field is required";
    });
  }

  String selectedMethod = "Visa";
  List<String> paymentMethods = ["Visa", "Master Card", "Mada", "Cash"];
  bool payLoading = false;
  //simulate paymnet
  simulatePayment() async {
    checkCard();
    checkCVV();
    checkExpire();
    if (cvvError.isNotEmpty || expireError.isNotEmpty || cardError.isNotEmpty)
      return;
    setState(() {
      payLoading = true;
    });

    await _stationcontroller.updateStationServiceCount(_station).then((value) {
      setState(() {
        payLoading = false;
      });
      Get.off(() => const PaymentDoneScreen());
    });
  }

  _callNumber(String number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  _openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stationId = args;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _stationcontroller.getStationInfo(stationId).then((station) {
        setState(() {
          _station = station;
          _distanceFromStation = _locationController
              .getDistanceFromPosition(station.location)
              .toInt();
          if (_distanceFromStation >= 1000) {
            //convert to km
            _distanceFromStation = (_distanceFromStation / 1000).toInt();
            _distanceUnit = " km";
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: _authController.currentUser.value.gender == "M"
                ? kMaleBackColor
                : kFemaleBackColor,
            body: Center(child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Obx(() => _stationcontroller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: size.width / 1.2,
                            child: Card(
                              color: _authController.currentUser.value.gender ==
                                      "M"
                                  ? kMaleButtonColor
                                  : kFemaleButtonColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(_station.name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: kHeadFontSize,
                                            color: kPrimiaryColor,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      _station.services,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: kHeadFontSize / 1.5,
                                          color: kHeadColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Cost:" +
                                          _station.cost.toString() +
                                          " SAR",
                                      style: const TextStyle(
                                          fontSize: kHeadFontSize / 1.1,
                                          color: kHeadColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Distance:" +
                                          _distanceFromStation.toString() +
                                          _distanceUnit,
                                      style: const TextStyle(
                                          fontSize: kHeadFontSize / 1.1,
                                          color: kHeadColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextButton.icon(
                                        style: kMainButtonStyle.copyWith(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(_authController
                                                            .currentUser
                                                            .value
                                                            .gender ==
                                                        "M"
                                                    ? const Color(0xff98afc7)
                                                    : const Color(0xffc5908e))),
                                        onPressed: () {
                                          setState(() {
                                            _callNumber(_station.phone);
                                          });
                                        },
                                        icon: const Icon(Icons.phone),
                                        label: const Text("Call")),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextButton.icon(
                                        style: kMainButtonStyle.copyWith(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(_authController
                                                            .currentUser
                                                            .value
                                                            .gender ==
                                                        "M"
                                                    ? const Color(0xff98afc7)
                                                    : const Color(0xffc5908e))),
                                        onPressed: () {
                                          setState(() {
                                            _openMap(_station.location.latitude,
                                                _station.location.longitude);
                                          });
                                        },
                                        icon: const Icon(Icons.location_pin),
                                        label: const Text("Open Map")),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kGeneralPadding),
                                      child: FormField<String>(
                                        builder:
                                            (FormFieldState<String> state) {
                                          return InputDecorator(
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                contentPadding: EdgeInsets.zero,
                                                hintText: "Payment Method",
                                                prefixIcon:
                                                    const Icon(Icons.payment),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0))),
                                            isEmpty: selectedMethod.isEmpty,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: selectedMethod,
                                                isDense: true,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedMethod = newValue!;
                                                    state.didChange(newValue);
                                                  });
                                                },
                                                items: paymentMethods
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
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
                                      height: 5,
                                    ),
                                    selectedMethod != "Cash"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            kGeneralPadding),
                                                child: Focus(
                                                  onFocusChange: (focus) {
                                                    if (!focus) checkCard();
                                                  },
                                                  child: TextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: const TextStyle(
                                                        fontSize:
                                                            kGeneralFontSize),
                                                    controller: cardController,
                                                    onChanged: (value) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                        errorStyle:
                                                            errorStyle.copyWith(
                                                                color:
                                                                    Colors.red),
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        errorText:
                                                            cardError.isEmpty
                                                                ? null
                                                                : cardError,
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        // icon: Icon(Icons.mail),
                                                        prefixIcon: const Icon(
                                                            Icons.payment),
                                                        // suffixIcon: phoneController.text.isEmpty
                                                        //     ? const Text('')
                                                        //     : GestureDetector(
                                                        //     onTap: () {
                                                        //       phoneController.clear();
                                                        //     },
                                                        //     child: const Icon(Icons.close)),
                                                        labelText:
                                                            'Card Number',
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .red,
                                                                    width: 1))),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        kGeneralPadding),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Focus(
                                                        onFocusChange: (focus) {
                                                          if (!focus)
                                                            checkExpire();
                                                        },
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          style: const TextStyle(
                                                              fontSize:
                                                                  kGeneralFontSize),
                                                          controller:
                                                              expireController,
                                                          onChanged: (value) {
                                                            setState(() {});
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                                  errorStyle: errorStyle
                                                                      .copyWith(
                                                                          color: Colors
                                                                              .red),
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  errorText: expireError
                                                                          .isEmpty
                                                                      ? null
                                                                      : expireError,
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  // icon: Icon(Icons.mail),
                                                                  prefixIcon:
                                                                      const Icon(
                                                                          Icons
                                                                              .date_range),
                                                                  // suffixIcon: phoneController.text.isEmpty
                                                                  //     ? const Text('')
                                                                  //     : GestureDetector(
                                                                  //     onTap: () {
                                                                  //       phoneController.clear();
                                                                  //     },
                                                                  //     child: const Icon(Icons.close)),
                                                                  labelText:
                                                                      'YY/MM',
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      borderSide: const BorderSide(
                                                                          color: Colors
                                                                              .red,
                                                                          width:
                                                                              1))),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Focus(
                                                      onFocusChange: (focus) {
                                                        if (!focus) checkCVV();
                                                      },
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style: const TextStyle(
                                                            fontSize:
                                                                kGeneralFontSize),
                                                        controller:
                                                            cvvController,
                                                        onChanged: (value) {
                                                          setState(() {});
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                                errorStyle: errorStyle
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .red),
                                                                filled: true,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                errorText: cvvError
                                                                        .isEmpty
                                                                    ? null
                                                                    : cvvError,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                // icon: Icon(Icons.mail),
                                                                prefixIcon:
                                                                    const Icon(
                                                                        Icons
                                                                            .code),
                                                                // suffixIcon: phoneController.text.isEmpty
                                                                //     ? const Text('')
                                                                //     : GestureDetector(
                                                                //     onTap: () {
                                                                //       phoneController.clear();
                                                                //     },
                                                                //     child: const Icon(Icons.close)),
                                                                labelText:
                                                                    'CVV',
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                8),
                                                                    borderSide: const BorderSide(
                                                                        color: Colors
                                                                            .red,
                                                                        width:
                                                                            1))),
                                                      ),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextButton.icon(
                                                        style: kMainButtonStyle.copyWith(
                                                            backgroundColor: MaterialStateProperty.all<
                                                                Color>(_authController
                                                                        .currentUser
                                                                        .value
                                                                        .gender ==
                                                                    "M"
                                                                ? const Color(
                                                                    0xff98afc7)
                                                                : const Color(
                                                                    0xffc5908e))),
                                                        onPressed: () {
                                                          simulatePayment();
                                                        },
                                                        icon: const Icon(
                                                            Icons.send),
                                                        label:
                                                            const Text("Pay")),
                                                    const SizedBox(width: 5),
                                                    payLoading
                                                        ? const CircularProgressIndicator()
                                                        : const SizedBox()
                                                  ]),
                                            ],
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                            ),
                          )),
                  ),
                ),
              );
            }))));
  }
}

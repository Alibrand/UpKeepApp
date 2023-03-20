import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:upkeepapp/constants.dart';
import 'package:upkeepapp/controller/auth_controller.dart';

class PaymentDoneScreen extends StatefulWidget {
  const PaymentDoneScreen({Key? key}) : super(key: key);

  @override
  State<PaymentDoneScreen> createState() => _PaymentDoneScreenState();
}

class _PaymentDoneScreenState extends State<PaymentDoneScreen> {
  //Auth Controller
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: _authController.currentUser.value.gender == "M"
                ? kMaleBackColor
                : kFemaleBackColor,
            body: Center(
                child: SizedBox(
              width: size.width / 1.2,
              height: size.height / 1.6,
              child: Card(
                color: _authController.currentUser.value.gender == "M"
                    ? kMaleButtonColor
                    : kFemaleButtonColor,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Payment Done Successfully",
                          style: const TextStyle(
                              fontSize: kHeadFontSize,
                              color: kHeadColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Service is in progress",
                          style: const TextStyle(
                              fontSize: kHeadFontSize,
                              color: kHeadColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextButton.icon(
                            style: kMainButtonStyle.copyWith(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        _authController
                                                    .currentUser.value.gender ==
                                                "M"
                                            ? const Color(0xff98afc7)
                                            : const Color(0xffc5908e))),
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                            label: const Text("Back")),
                      ],
                    )),
              ),
            ))));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upkeepapp/controller/auth_controller.dart';
import 'package:upkeepapp/screens/stations_screen.dart';

import '../constants.dart';

class BotChatScreen extends StatefulWidget {
  const BotChatScreen({Key? key}) : super(key: key);

  @override
  _BotChatScreenState createState() => _BotChatScreenState();
}

class _BotChatScreenState extends State<BotChatScreen> {
  //Auth Controller
  final _authController = Get.find<AuthController>();

  final List _questions = [
    {
      'question': "Asking about Working hours?",
      'answer':
          'We are online 24/7,but actual Working hours depend on the plan of every station. ',
    },
    {
      'question': "Do you have 'payment when receiving' feature? ",
      'answer': 'Yes,you can choose the best payment method for you.',
    },
    {
      'question': "How long does the order takes to be ready?",
      'answer': 'It depends on the distance between you and the station',
    },
    {
      'question': "Do you have a problem with your car wheels?",
      'answer': 'Contact with nearest available car wheels station',
      'type': "Wheels",
    },
    {
      'question': "Is your car out of fuel?",
      'answer': 'Contact with nearest available petrol station',
      'type': "Petrol"
    },
    {
      'question': "Do you have a problem with your car Electricity?",
      'answer': 'Contact with nearest available car Electricity station',
      'type': "Car Electricity"
    },
    {
      'question': "Do you need a winch to lift your card?",
      'answer': 'Contact with nearest available winch ',
      'type': "Winch"
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: _authController.currentUser.value.gender == "M"
                ? kMaleBackColor
                : kFemaleBackColor,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    "Frequently Asked Questions",
                    style: TextStyle(
                        fontSize: kHeadFontSize,
                        color: kPrimiaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _questions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ExpansionTile(
                            expandedAlignment: Alignment.centerLeft,
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            tilePadding: const EdgeInsets.all(2),
                            childrenPadding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            title: Text(_questions[index]['question']),
                            children: [
                              Text(_questions[index]['answer']),
                              _questions[index]['type'] == null
                                  ? const SizedBox()
                                  : TextButton(
                                      onPressed: () {
                                        Get.to(() => StationsScreen(),
                                            arguments: _questions[index]
                                                ['type']);
                                      },
                                      child: Text("Go to " +
                                          _questions[index]['type'] +
                                          " Stations"),
                                    )
                            ],
                          ),
                        )),
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}

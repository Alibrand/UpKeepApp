import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upkeepapp/controller/auth_controller.dart';
import 'package:upkeepapp/model/FireUser.dart';

import '../constants.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  //Auth Controller
  final _authController = Get.find<AuthController>();

  //TextEditing Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController carmodelController = TextEditingController();

  String selectedGender = "M";
  //String selectedMethod = "Visa";
  // List<String> paymentMethods = [
  //   "Visa",
  //   "Master Card",
  //   "Mada",
  //   "Apple pay",
  //   "Cash"
  // ];
  //

  String emailError = "",
      passError = "",
      confirmError = "",
      phoneError = "",
      nameError = "",
      cityError = "",
      carmodelerror = "";

  bool isVisible = true;
  checkEmail() {
    setState(() {
      bool emailValid =
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@gmail.com")
              .hasMatch(emailController.text);
      emailError = emailController.text.isNotEmpty
          ? emailValid
              ? ""
              : "Invalid email: should be like example@gmail.com"
          : "This field is required";
    });
  }

  checkPasswords() {
    setState(() {
      passError = passwordController.text.isEmpty
          ? "This field is required"
          : confirmpasswordController.text != passwordController.text
              ? "Passwords don't match"
              : "";
      confirmError = confirmpasswordController.text.isEmpty
          ? "This field is required"
          : confirmpasswordController.text != passwordController.text
              ? "Passwords don't match"
              : "";
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

  checkCity() {
    setState(() {
      cityError =
          cityController.text.isNotEmpty ? "" : "This field is required";
    });
  }

  checkCarModel() {
    setState(() {
      carmodelerror =
          carmodelController.text.isNotEmpty ? "" : "This field is required";
    });
  }

  //Function handles TextFields Validating
  bool validateForm() {
    bool check = true;
    checkEmail();
    checkName();
    checkPasswords();

    checkPhone();
    checkCity();
    checkCarModel();
    bool empty = emailError.isNotEmpty ||
        passError.isNotEmpty ||
        confirmError.isNotEmpty ||
        phoneError.isNotEmpty ||
        nameError.isNotEmpty ||
        cityError.isNotEmpty ||
        carmodelerror.isNotEmpty;
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
                                  "Create Account",
                                  style: TextStyle(
                                      fontSize: kHeadFontSize,
                                      color: kPrimiaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Obx(() => _authController.isLoading.value
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
                                  if (!focus) checkEmail();
                                },
                                child: TextField(
                                  style: const TextStyle(
                                      fontSize: kGeneralFontSize),
                                  controller: emailController,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                      errorStyle: errorStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorText: emailError.isEmpty
                                          ? null
                                          : emailError,
                                      contentPadding: EdgeInsets.zero,
                                      // icon: Icon(Icons.mail),
                                      prefixIcon: const Icon(Icons.mail),
                                      suffixIcon: emailController.text.isEmpty
                                          ? const Text('')
                                          : GestureDetector(
                                              onTap: () {
                                                emailController.clear();
                                              },
                                              child: const Icon(Icons.close)),
                                      hintText: 'example@gmail.com',
                                      labelText: 'Email',
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
                                      errorStyle: errorStyle,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                  groupValue: selectedGender,
                                  fillColor: MaterialStateProperty.all<Color>(
                                      Colors.white),
                                  value: "M",
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value.toString();
                                    });
                                  },
                                ),
                                const Text(
                                  "Male",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Radio(
                                  groupValue: selectedGender,
                                  fillColor: MaterialStateProperty.all<Color>(
                                      Colors.white),
                                  value: "F",
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value.toString();
                                    });
                                  },
                                ),
                                const Text(
                                  "Female",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
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
                                      errorStyle: errorStyle,
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
                                  if (!focus) checkCity();
                                },
                                child: TextField(
                                  style: const TextStyle(
                                      fontSize: kGeneralFontSize),
                                  controller: cityController,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                      errorStyle: errorStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorText:
                                          cityError.isEmpty ? null : cityError,
                                      contentPadding: EdgeInsets.zero,
                                      // icon: Icon(Icons.mail),
                                      prefixIcon:
                                          const Icon(Icons.location_city),
                                      suffixIcon: cityController.text.isEmpty
                                          ? const Text('')
                                          : GestureDetector(
                                              onTap: () {
                                                cityController.clear();
                                              },
                                              child: const Icon(Icons.close)),
                                      labelText: 'City',
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
                                  if (!focus) checkCarModel();
                                },
                                child: TextField(
                                  style: const TextStyle(
                                      fontSize: kGeneralFontSize),
                                  controller: carmodelController,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                      errorStyle: errorStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorText: carmodelerror.isEmpty
                                          ? null
                                          : carmodelerror,
                                      contentPadding: EdgeInsets.zero,
                                      // icon: Icon(Icons.mail),
                                      prefixIcon:
                                          const Icon(Icons.flip_camera_android),
                                      suffixIcon: carmodelController
                                              .text.isEmpty
                                          ? const Text('')
                                          : GestureDetector(
                                              onTap: () {
                                                carmodelController.clear();
                                              },
                                              child: const Icon(Icons.close)),
                                      labelText: 'Car Model',
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
                                  if (!focus) checkPasswords();
                                },
                                child: TextField(
                                  style: const TextStyle(
                                      fontSize: kGeneralFontSize),
                                  obscureText: isVisible,
                                  controller: passwordController,
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                      errorStyle: errorStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorText:
                                          passError.isEmpty ? null : passError,
                                      contentPadding: EdgeInsets.zero,
                                      prefixIcon: const Icon(Icons.lock),
                                      suffixIcon: GestureDetector(
                                          onTap: () {
                                            isVisible = !isVisible;
                                            setState(() {});
                                          },
                                          child: Icon(isVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off)),
                                      hintText: 'Type your password',
                                      labelText: 'Password',
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
                                  if (!focus) checkPasswords();
                                },
                                child: TextField(
                                  style: const TextStyle(
                                      fontSize: kGeneralFontSize),
                                  obscureText: isVisible,
                                  controller: confirmpasswordController,
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                      errorStyle: errorStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorText: confirmError.isEmpty
                                          ? null
                                          : confirmError,
                                      contentPadding: EdgeInsets.zero,
                                      prefixIcon: const Icon(Icons.lock),
                                      suffixIcon: GestureDetector(
                                          onTap: () {
                                            isVisible = !isVisible;
                                            setState(() {});
                                          },
                                          child: Icon(isVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off)),
                                      labelText: 'Confirm Password',
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
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: kGeneralPadding),
                            //   child: FormField<String>(
                            //     builder: (FormFieldState<String> state) {
                            //       return InputDecorator(
                            //         decoration: InputDecoration(
                            //             contentPadding: EdgeInsets.zero,
                            //             hintText: "Payment Method",
                            //             prefixIcon: const Icon(Icons.payment),
                            //             border: OutlineInputBorder(
                            //                 borderRadius:
                            //                     BorderRadius.circular(5.0))),
                            //         isEmpty: selectedMethod.isEmpty,
                            //         child: DropdownButtonHideUnderline(
                            //           child: DropdownButton<String>(
                            //             value: selectedMethod,
                            //             isDense: true,
                            //             onChanged: (newValue) {
                            //               setState(() {
                            //                 selectedMethod = newValue!;
                            //                 state.didChange(newValue);
                            //               });
                            //             },
                            //             items:
                            //                 paymentMethods.map((String value) {
                            //               return DropdownMenuItem<String>(
                            //                 value: value,
                            //                 child: Text(value),
                            //               );
                            //             }).toList(),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 16,
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kGeneralPadding),
                              child: TextButton(
                                  style: kMainButtonStyle,
                                  onPressed: () async {
                                    if (!validateForm()) return;
                                    FireUser user = FireUser(
                                        fullName: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        car_model: carmodelController.text,
                                        city: cityController.text,
                                        payment_method: "",
                                        phone_number: phoneController.text,
                                        gender: selectedGender);
                                    _authController.userRegisterProfile(user);
                                  },
                                  child: const SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Create Account",
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(fontSize: kGeneralFontSize),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ))));
            }))));
  }
}

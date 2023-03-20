import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upkeepapp/constants.dart';
import 'package:upkeepapp/controller/auth_controller.dart';
import 'package:upkeepapp/screens/create_account_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Auth Controller
  final _authController = Get.find<AuthController>();

  //TextEditing Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String emailError = "";
  String passError = "";
  bool isVisible = true;

  //Function handles TextFields Validating
  bool validateForm() {
    var empty = false;
    setState(() {
      emailError = emailController.text.isEmpty ? "This Field is required" : "";
      passError =
          passwordController.text.isEmpty ? "This Field is required" : "";
    });

    empty = emailController.text.isEmpty || passwordController.text.isEmpty;

    return !empty;
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
                            SizedBox(
                                width: 150,
                                height: 150,
                                child: Image.asset('assets/images/icon.png')),
                            const SizedBox(
                              height: 15,
                            ),
                            Obx(() => _authController.isLoading.value
                                ? const CircularProgressIndicator()
                                : const SizedBox()),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kGeneralPadding),
                              child: Focus(
                                onFocusChange: (focus) {
                                  if (!focus) validateForm();
                                },
                                child: TextField(
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
                                      // icon: Icon(Icons.mail),
                                      prefixIcon: const Icon(Icons.mail),
                                      suffixIcon: emailController.text.isEmpty
                                          ? const Text('')
                                          : GestureDetector(
                                              onTap: () {
                                                emailController.clear();
                                              },
                                              child: const Icon(Icons.close)),
                                      hintText: 'example@mail.com',
                                      labelText: 'Email',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 1))),
                                ),
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
                                  if (!focus) validateForm();
                                },
                                child: TextField(
                                  obscureText: isVisible,
                                  controller: passwordController,
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                      errorStyle: errorStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorText:
                                          passError.isEmpty ? null : passError,
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
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kGeneralPadding),
                              child: TextButton(
                                  style: kMainButtonStyle.copyWith(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              kLoginButtonColor)),
                                  onPressed: () async {
                                    if (!validateForm()) return;
                                    final email = emailController.text;
                                    final password = passwordController.text;
                                    _authController.userSignIn(email, password);
                                  },
                                  child: const SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Log In",
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(fontSize: kGeneralFontSize),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kGeneralPadding),
                              child: TextButton(
                                  style: kSecButtonStyle.copyWith(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              kCreateAccountButtonColor)),
                                  onPressed: () => {
                                        Get.to(
                                            () => const CreateAccountScreen())
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
                          ],
                        ),
                      ))));
            }))));
  }
}

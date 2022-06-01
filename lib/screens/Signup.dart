import 'package:exams/controllers/auth_controller.dart';
import 'package:exams/screens/home_page.dart';
import 'package:exams/utils/colors.dart';
import 'package:exams/utils/comon_widgets.dart';

import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: appBar(context, "Create a new account"),
      body: Stack(
        children: <Widget>[
          Container(
            color: blueAccentColor,
            child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: deviceSize.height * 0.25,
                  width: deviceSize.width * 0.60,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Join US",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        20.height,
                        const Text(
                          'Exams',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                height: deviceSize.height * 0.75,
                width: deviceSize.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          authController
                              .checkSignupEmail(emailController.text.trim());
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: const TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      20.height,
                      Obx(
                        () => TextFormField(
                          onChanged: (value) {
                            authController.checkSignupPassword(
                                passwordController.text.trim());
                          },
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText:
                              authController.isVisible.value ? true : false,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  authController.toggleVisibility();
                                },
                                icon: Icon(!authController.isVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            hintText: "Password",
                            hintStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      15.height,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx((() => CircleAvatar(
                              minRadius: 5.0,
                              maxRadius: 5.0,
                              backgroundColor:
                                  authController.isEmailSignupValid.value
                                      ? Colors.green
                                      : redColor))),
                          10.width,
                          Obx((() => Text(
                                authController.isEmailSignupValid.value
                                    ? "email is valid"
                                    : "email is not valid",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              )))
                        ],
                      ),
                      15.height,
                      Row(
                        children: [
                          Obx((() => CircleAvatar(
                              minRadius: 5.0,
                              maxRadius: 5.0,
                              backgroundColor:
                                  authController.isPasswordSignupValid.value
                                      ? Colors.green
                                      : redColor))),
                          10.width,
                          Obx((() => Text(
                                authController.isPasswordSignupValid.value
                                    ? "password is valid"
                                    : "password can't be less than 5 chars",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              )))
                        ],
                      ),
                      15.height,
                      Obx((() => authController.isLoading.value
                          ? loadingRow()
                          : appButton(
                              widget: Text("Signup",
                                  style: boldTextStyle(color: white, size: 18)),
                              label: "Signup",
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                if (authController.isEmailSignupValid.value &&
                                    authController
                                        .isPasswordSignupValid.value) {
                                  authController
                                      .signupUser(
                                          emailController.text.trim(),
                                          passwordController.text.trim(),
                                          context)
                                      .then((user) {
                                    if (user != null) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeDashBoard()),
                                          (route) => false);
                                      displayMessage(
                                          "logged in successfully", context);
                                    }
                                  });
                                } else {
                                  displayMessage(
                                      "all fields are required", context);
                                }
                              },
                              btnWidth: deviceSize.width * .5))),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: stepper(0, 0))
        ],
      ),
    );
  }
}

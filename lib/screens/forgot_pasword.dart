import 'package:exams/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';
import '../utils/comon_widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
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
                      children: const [
                        Text(
                          'forgot password',
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
                                .checkFPEmail(emailController.text.trim());
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
                        15.height,
                        Row(
                          children: [
                            Obx((() => CircleAvatar(
                                minRadius: 5.0,
                                maxRadius: 5.0,
                                backgroundColor:
                                    authController.isEmailFPValid.value
                                        ? Colors.green
                                        : redColor))),
                            5.width,
                            Obx((() => Text(
                                  authController.isEmailFPValid.value
                                      ? "email is valid"
                                      : "email is not valid",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                )))
                          ],
                        ),
                        30.height,
                        Obx(
                          (() => authController.isLoading.value
                              ? loadingRow()
                              : appButton(
                                  widget: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.email),
                                      5.width,
                                      Text("Reset Password",
                                          style: boldTextStyle(
                                              color: white, size: 18)),
                                    ],
                                  ),
                                  label: "Reset Password",
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    if (authController.isEmailFPValid.value) {
                                      authController.resetPassword(
                                          emailController.text, context);
                                    } else {
                                      displayMessage(
                                          "emal is required", context);
                                    }
                                  },
                                  btnWidth: deviceSize.width * .5,
                                )),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Align(alignment: Alignment.bottomCenter, child: stepper(2, 2))
        ],
      ),
    );
  }
}

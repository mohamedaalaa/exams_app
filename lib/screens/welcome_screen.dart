import 'package:exams/controllers/auth_controller.dart';
import 'package:exams/main.dart';
import 'package:exams/screens/students_quizes.dart';
import 'package:exams/utils/colors.dart';
import 'package:exams/utils/comon_widgets.dart';
import 'package:exams/utils/sizes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);

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
                          'Welcome',
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
                                Column(
                                  children: [
                                    Obx(
                                      () => appButton(
                                          btnWidth: deviceSize.width * .5,
                                          label: "teacher",
                                          widget: const Text("teacher"),
                                          backgroundColor:
                                              authController.isTeacher.value
                                                  ? blueAccentColor
                                                  : grey,
                                          onTap: () {
                                            if (authController
                                                .isTeacher.value) {
                                              null;
                                            } else {
                                              authController.toggleTeacher();
                                            }
                                          }),
                                    ),
                                    gapH10,
                                    Obx(
                                      () => appButton(
                                          btnWidth: deviceSize.width * .5,
                                          label: "student",
                                          widget: const Text("student"),
                                          backgroundColor:
                                              authController.isTeacher.value
                                                  ? grey
                                                  : blueAccentColor,
                                          onTap: () {
                                            if (!authController
                                                .isTeacher.value) {
                                              null;
                                            } else {
                                              authController.toggleTeacher();
                                            }
                                          }),
                                    ),
                                    gapH15,
                                    roundedButton1(
                                        btnWidth: deviceSize.width * .3,
                                        label: "Login",
                                        onTap: () {
                                          Navigator.of(context).pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      authController
                                                              .isTeacher.value
                                                          ? const HomePage()
                                                          : const StudentsQuiz()),
                                              (route) => false);
                                        })
                                  ],
                                )
                              ])))))
        ],
      ),
    );
  }
}

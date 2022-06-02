import 'package:exams/screens/students_quizes.dart';
import 'package:exams/utils/colors.dart';
import 'package:exams/utils/comon_widgets.dart';
import 'package:exams/utils/sizes.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int correct;
  final int inCorrect;
  final int total;
  const Result({
    Key? key,
    required this.correct,
    required this.inCorrect,
    required this.total,
  }) : super(key: key);

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
                  child: const Center(
                    child: Text(
                      'Result',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (correct >= 3)
                          const Text(
                            "Congratulation yppu passed the exam",
                            style:
                                TextStyle(color: blueAccentColor, fontSize: 20),
                          ),
                        Text(
                          "Degree = $correct",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: blueAccentColor),
                        ),
                        gapH20,
                        appButton(
                            label: "Back to exams",
                            widget: const Text("Back to exams"),
                            onTap: () => Navigator.of(context)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StudentsQuiz()),
                                    (route) => false))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

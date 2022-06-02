import 'package:exams/screens/home_page.dart';
import 'package:exams/utils/colors.dart';
import 'package:exams/utils/comon_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quiz_controller.dart';
import '../utils/sizes.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  const AddQuestion({Key? key, required this.quizId}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _key = GlobalKey<FormState>();
  final quizController = Get.put(QuizController());
  String question = "", option1 = "", option2 = "", option3 = "", option4 = "";

  void addQuestionData() async {
    Map<String, dynamic> questionsData = {
      "question": question,
      "option 1": option1,
      "option 2": option2,
      "option 3": option3,
      "option 4": option4,
    };

    await quizController
        .addQuestionData(questionsData, widget.quizId, context)
        .then((value) {
      clearTextFormFields();
      displayMessage(
          "question added sucessfully to Quiz with id ${widget.quizId}",
          context);
    });
  }

  void clearTextFormFields() {
    question = "";
    option1 = "";
    option2 = "";
    option3 = "";
    option4 = "";
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("questions"),
        backgroundColor: blueAccentColor,
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Obx(
            () => quizController.isLoading.value
                ? Center(
                    child: loadingRow(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          question = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter a question";
                          } else if (value.length < 6) {
                            return "question can't be less than 6 chars";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "question",
                        ),
                      ),
                      gapH10,
                      TextFormField(
                        onChanged: (value) {
                          option1 = value;
                        },
                        validator: (value) =>
                            value!.isEmpty ? "Enter answer" : null,
                        decoration: const InputDecoration(
                          hintText: "option 1 (correct Answer)",
                        ),
                      ),
                      gapH10,
                      TextFormField(
                        onChanged: (value) {
                          option2 = value;
                        },
                        validator: (value) =>
                            value!.isEmpty ? "Enter answer" : null,
                        decoration: const InputDecoration(
                          hintText: "option 2",
                        ),
                      ),
                      gapH10,
                      TextFormField(
                        onChanged: (value) {
                          option3 = value;
                        },
                        validator: (value) =>
                            value!.isEmpty ? "Enter answer" : null,
                        decoration: const InputDecoration(
                          hintText: "option 3",
                        ),
                      ),
                      gapH10,
                      TextFormField(
                        onChanged: (value) {
                          option4 = value;
                        },
                        validator: (value) =>
                            value!.isEmpty ? "Enter answer" : null,
                        decoration: const InputDecoration(
                          hintText: "option 4",
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          roundedButton1(
                              label: "Submit",
                              onTap: () {
                                quizController
                                    .getQuizData(widget.quizId, context)
                                    .then((value) {
                                  if (value!.docs.length < 5) {
                                    displayMessage(
                                        "exam questions can't be less than 5",
                                        context);
                                  } else {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeDashBoard()));
                                    displayMessage(
                                        "quiz created successfully", context);
                                  }
                                });
                              },
                              btnWidth: width / 2 - 36),
                          roundedButton1(
                              label: "Add Question",
                              btnWidth: width / 2 - 36,
                              onTap: () {
                                bool isValid = _key.currentState!.validate();
                                if (isValid) {
                                  addQuestionData();
                                } else {
                                  displayMessage(
                                      "all fields are required", context);
                                }
                              })
                        ],
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

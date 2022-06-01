import 'package:exams/controllers/quiz_controller.dart';
import 'package:exams/screens/questions.dart';
import 'package:exams/utils/colors.dart';
import 'package:exams/utils/sizes.dart';
import 'package:exams/utils/comon_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final _key = GlobalKey<FormState>();
  String quizId = "";
  final quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Quiz"),
        backgroundColor: blueAccentColor,
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              controller: titleController,
              validator: (value) =>
                  value!.isEmpty ? "value can't be empty" : null,
              decoration: const InputDecoration(
                hintText: "title",
              ),
            ),
            gapH10,
            TextFormField(
              controller: descController,
              validator: (value) =>
                  value!.isEmpty ? "value can't be empty" : null,
              decoration: const InputDecoration(
                hintText: "description",
              ),
            ),
            const Spacer(),
            Obx(() => quizController.isLoading.value
                ? loadingRow()
                : roundedButton1(
                    label: "Create Quiz",
                    btnWidth: width / 2,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      bool valid = _key.currentState!.validate();
                      if (valid) {
                        addQuizData();
                        //quizController.addQuizData(quizData, quizId, context);
                      } else {
                        displayMessage("all fields are required", context);
                      }
                    }))
          ]),
        ),
      ),
    );
  }

  void addQuizData() async {
    quizId = randomAlphaNumeric(16);
    Map<String, dynamic> quizData = {
      "quizId": quizId,
      "quizDescription": descController.text,
      "quizTitle": titleController.text
    };

    await quizController.addQuizData(quizData, quizId, context).then((value) {
      displayMessage(
          "quiz ccreated successfully please enter exam questions", context);
      clearTextFields();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddQuestion(
                quizId: quizId,
              )));
    });
  }

  void clearTextFields() {
    titleController.text = "";
    descController.text = "";
  }
}

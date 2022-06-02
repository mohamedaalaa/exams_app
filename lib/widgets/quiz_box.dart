import 'package:exams/screens/take_quiz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class QuizBox extends StatelessWidget {
  final String title;
  final String desc;
  final String quizId;

  QuizBox({
    Key? key,
    required this.title,
    required this.desc,
    required this.quizId,
  }) : super(key: key);

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        onTap: () {
          !authController.isTeacher.value
              ? Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => TakeQuiz(
                            quizId: quizId,
                          )),
                  (route) => false)
              : null;
        },
        leading: CircleAvatar(
          backgroundColor: Colors.purple,
          child: Image.asset(
            "assets/images/exam.png",
            fit: BoxFit.cover,
          ),
        ),
        title: Text(title),
        subtitle: Text(desc),
      ),
    );
  }
}

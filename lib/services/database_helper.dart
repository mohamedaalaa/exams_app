import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exams/utils/comon_widgets.dart';
import 'package:flutter/cupertino.dart';

class DataBaseHelper {
  final auth = FirebaseFirestore.instance;

  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId,
      BuildContext context) async {
    await auth.collection("Quiz").doc(quizId).set(quizData).catchError((error) {
      displayMessage(error.toString(), context);
    });
  }

  Future<void> addQuestionData(Map<String, dynamic> questionDtata,
      String quizId, BuildContext context) async {
    await auth
        .collection("Quiz")
        .doc(quizId)
        .collection("Ques And Ans")
        .add(questionDtata)
        .catchError((error) {
      displayMessage(error.toString(), context);
    });
  }

  Future<void> deleteQuiz(String quizId, BuildContext context) async {
    await auth.collection("Quiz").doc(quizId).delete().catchError((error) {
      displayMessage(error.toString(), context);
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>?> getQuizQuestions(
      String quizId, BuildContext context) async {
    var data = await auth
        .collection("Quiz")
        .doc(quizId)
        .collection("Ques And Ans")
        .get()
        .catchError((error) {
      displayMessage(error.toString(), context);
    });

    return data;
  }
}

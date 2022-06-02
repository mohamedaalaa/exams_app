import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exams/services/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId,
      BuildContext context) async {
    try {
      isLoading(true);
      await DataBaseHelper().addQuizData(quizData, quizId, context);
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteQuiz(String quizId, BuildContext context) async {
    try {
      isLoading(true);
      await DataBaseHelper().deleteQuiz(quizId, context);
    } finally {
      isLoading(false);
    }
  }

  Future<void> addQuestionData(Map<String, dynamic> qustionsData, String quizId,
      BuildContext context) async {
    try {
      isLoading(true);
      await DataBaseHelper().addQuestionData(qustionsData, quizId, context);
    } finally {
      isLoading(false);
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>?> getQuizData(
      String quizId, BuildContext context) async {
    try {
      isLoading(true);
      var data = await DataBaseHelper().getQuizQuestions(quizId, context);
      return data;
    } finally {
      isLoading(false);
    }
  }
}

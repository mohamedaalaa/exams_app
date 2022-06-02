import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exams/screens/welcome_screen.dart';
import 'package:exams/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../utils/comon_widgets.dart';
import '../widgets/quiz_box.dart';

class StudentsQuiz extends StatefulWidget {
  const StudentsQuiz({Key? key}) : super(key: key);

  @override
  State<StudentsQuiz> createState() => _StudentsQuizState();
}

class _StudentsQuizState extends State<StudentsQuiz> {
  Stream quizStream = FirebaseFirestore.instance.collection("Quiz").snapshots();
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qiuzes"),
        backgroundColor: blueAccentColor,
        actions: [
          Obx(
            () => authController.isLoading.value
                ? loadingRow()
                : IconButton(
                    onPressed: () {
                      authController.signOut(context).then((value) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => WelcomePage()));
                      });
                    },
                    icon: const Icon(Icons.logout)),
          )
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: quizStream,
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                const Center(
                  child: Text("something went wrong"),
                );
                break;
              case ConnectionState.waiting:
                Center(
                  child: loadingRow(),
                );
                break;

              case ConnectionState.active:
                final quizes = snapshot.data.docs;
                return quizes.isEmpty
                    ? Center(
                        child: Image.asset(
                          "assets/images/empty.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    : ListView.builder(
                        itemCount: quizes.length,
                        itemBuilder: (context, i) {
                          return QuizBox(
                            title: quizes[i]["quizTitle"],
                            desc: quizes[i]["quizDescription"],
                            quizId: quizes[i]["quizId"],
                          );
                        },
                      );
              case ConnectionState.done:
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }
}

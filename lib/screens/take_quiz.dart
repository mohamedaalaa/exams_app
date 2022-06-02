import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exams/controllers/quiz_controller.dart';
import 'package:exams/models/question_model.dart';
import 'package:exams/screens/option_tile.dart';
import 'package:exams/utils/comon_widgets.dart';
import 'package:exams/utils/sizes.dart';
import 'package:exams/widgets/result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../services/database_helper.dart';

int total = 0;
int correct = 0;
int wrong = 0;

class TakeQuiz extends StatefulWidget {
  final String quizId;
  const TakeQuiz({Key? key, required this.quizId}) : super(key: key);

  @override
  State<TakeQuiz> createState() => _TakeQuizState();
}

class _TakeQuizState extends State<TakeQuiz> {
  final quizController = Get.put(QuizController());
  QuerySnapshot<Map<String, dynamic>>? querySnapshot;

  QuestionModel getQuestionData(
      QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    List<String> options = [
      documentSnapshot["option 1"],
      documentSnapshot["option 2"],
      documentSnapshot["option 3"],
      documentSnapshot["option 4"],
    ];
    options.shuffle();

    QuestionModel questionModel = QuestionModel(
        question: documentSnapshot["question"],
        option1: options[0],
        option2: options[1],
        option3: options[2],
        correctAnswer: documentSnapshot["option 1"],
        answered: false,
        option4: options[3]);
    return questionModel;
  }

  @override
  void dispose() {
    correct = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("take quiz"),
      ),
      body: FutureBuilder(
        future: DataBaseHelper()
            .getQuizQuestions(widget.quizId, context)
            .then((value) {
          querySnapshot = value;
          total = value!.docs.length;
        }),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(
                child: Text("wrong"),
              );

            case ConnectionState.waiting:
              return Center(
                child: loadingRow(),
              );

            case ConnectionState.active:
              return const Center(child: Text("done"));

            case ConnectionState.done:
              return ListView.builder(
                  itemCount: querySnapshot!.docs.length,
                  itemBuilder: (context, i) {
                    return QuizPlayTile(
                        model: getQuestionData(querySnapshot!.docs[i]),
                        index: i);
                  });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Center(
              child: Text(
            "result",
            style: TextStyle(color: whiteColor),
          )),
          onPressed: () {
            if (total == 0) {
              Navigator.of(context)
                  .pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => Result(
                              correct: correct,
                              inCorrect: wrong,
                              total: total)),
                      (route) => false)
                  .then((value) {});
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Warning'),
                    content: const Text("you haven't answered all ques yet"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => Result(
                                      correct: correct,
                                      inCorrect: wrong,
                                      total: total)),
                              (route) => false);
                        },
                        child: const Text('ACCEPT'),
                      ),
                    ],
                  );
                },
              );
            }
          }),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel model;
  final int index;

  const QuizPlayTile({Key? key, required this.model, required this.index})
      : super(key: key);

  @override
  State<QuizPlayTile> createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  void checkAnswer(String correctAnswer, String answer) {}

  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Q${widget.index + 1} ${widget.model.question}",
            style: const TextStyle(
                color: blackColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          gapH8,
          GestureDetector(
              onTap: () {
                if (!widget.model.answered) {
                  if (widget.model.option1 == widget.model.correctAnswer) {
                    optionSelected = widget.model.option1;
                    widget.model.answered = true;
                    correct++;
                    total--;
                    setState(() {});
                  } else {
                    optionSelected = widget.model.option1;
                    widget.model.answered = true;
                    total--;
                    setState(() {});
                  }
                }
              },
              child: OptionTile(
                answered: widget.model.answered,
                option: widget.model.option1,
                optionSelected: optionSelected,
                correctAnswer: widget.model.correctAnswer,
                mark: 'A',
              )),
          gapH8,
          GestureDetector(
              onTap: () {
                if (!widget.model.answered) {
                  if (widget.model.option2 == widget.model.correctAnswer) {
                    optionSelected = widget.model.option2;
                    widget.model.answered = true;
                    correct++;
                    total--;
                    setState(() {});
                  } else {
                    optionSelected = widget.model.option2;
                    widget.model.answered = true;
                    total--;
                    setState(() {});
                  }
                }
              },
              child: OptionTile(
                answered: widget.model.answered,
                option: widget.model.option2,
                optionSelected: optionSelected,
                correctAnswer: widget.model.correctAnswer,
                mark: 'B',
              )),
          gapH8,
          GestureDetector(
            onTap: () {
              if (!widget.model.answered) {
                if (widget.model.option3 == widget.model.correctAnswer) {
                  optionSelected = widget.model.option3;
                  widget.model.answered = true;
                  correct++;
                  total--;
                  setState(() {});
                } else {
                  optionSelected = widget.model.option3;
                  widget.model.answered = true;
                  total--;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              answered: widget.model.answered,
              option: widget.model.option3,
              optionSelected: optionSelected,
              correctAnswer: widget.model.correctAnswer,
              mark: 'C',
            ),
          ),
          gapH8,
          GestureDetector(
              onTap: () {
                if (!widget.model.answered) {
                  if (widget.model.option4 == widget.model.correctAnswer) {
                    optionSelected = widget.model.option4;
                    widget.model.answered = true;
                    correct++;
                    total--;
                    setState(() {});
                  } else {
                    optionSelected = widget.model.option4;
                    widget.model.answered = true;
                    total--;
                    setState(() {});
                  }
                }
              },
              child: OptionTile(
                answered: widget.model.answered,
                option: widget.model.option4,
                optionSelected: optionSelected,
                correctAnswer: widget.model.correctAnswer,
                mark: 'D',
              ))
        ],
      ),
    );
  }
}

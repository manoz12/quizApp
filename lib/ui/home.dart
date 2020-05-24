import 'package:flutter/material.dart';

import 'package:quizzler/quizzmodel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizModel quizModel = QuizModel();

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizModel.getCorrectAnswer();
    setState(() {
      if (quizModel.isFinished() == true) {
        Alert(
                context: context,
                title: 'Finished !',
                desc: 'You\'ve reached the end of the quiz.')
            .show();
        quizModel.reset();
        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizModel.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    quizModel.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: FlatButton(
                      color: Colors.green,
                      onPressed: () {
                        checkAnswer(true);
                      },
                      child: Text(
                        'True',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ))),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    checkAnswer(false);
                  },
                  child: Text(
                    'False',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
            )),
            Row(
              children: scoreKeeper,
            )
          ],
        ),
      ),
    );
  }
}

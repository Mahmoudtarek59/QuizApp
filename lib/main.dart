import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Icon> scoreKeeper = new List<Icon>();
  int result = 0;
  void checkAnswer(bool answer) {
    setState(() {
      if (!quizBrain.isFinished()) {
        if (quizBrain.answer() == answer) {
          result++;
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizBrain.nextQuestion();
      } else {
        Alert(context: context, title: "${result} / 13", desc: "you've reached the end of Quiz")
            .show();
        result=0;
        scoreKeeper.clear();
        quizBrain.resetQuiz();
      }
    });
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      quizBrain.questions(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: FlatButton(
                    onPressed: () => checkAnswer(true),
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Text(
                      "True",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: FlatButton(
                    onPressed: () => checkAnswer(false),
                    textColor: Colors.white,
                    color: Colors.red,
                    child: Text(
                      "False",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Row(
                children: scoreKeeper,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_quizz/models/Question.dart';
import 'package:flutter_quizz/widgets/QuizzPage.dart';
import 'package:flutter_quizz/widgets/CustomText.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {

  List<Question> listQuestion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          //backgroundColor: Colors.redAccent,
          elevation: 10.0,
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 10.0,
                margin: EdgeInsets.all(20.0),
                child: new Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.height * 0.4,
                  child: new Image.asset(
                    'ImageAssets/cover.jpg',
                    fit: BoxFit.fitHeight,),
                ),
              ),
              ElevatedButton(
                onPressed: navToQuizz,
                child: CustomText(
                  'Commencer le quizz',
                  factor: 1.2
                  ),
                ),
            ],
          ),
        )
    );
  }

  void navToQuizz() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) {
              return new QuizzPage();
            }
        )
    );
  }
}
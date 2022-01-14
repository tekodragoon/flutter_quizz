import 'package:flutter/material.dart';
import 'package:flutter_quizz/models/Question.dart';
import 'package:flutter_quizz/widgets/CustomText.dart';

class QuizzPage extends StatefulWidget {

  @override
  _QuizzPage createState() => new _QuizzPage();

}

class _QuizzPage extends State<QuizzPage> {

  Question actualQuestion;

  List<Question> listQuestion = [
    new Question("La devise de la Belgique est:\n \" l'union fait la force \"", true, "", "belgique.jpg"),
    new Question('La lune va finir par tomber sur Terre à cause de la gravité', false, "Au contraire la lune s'éloigne", 'lune.jpg'),
    new Question('La Russie est plus grande en superficie que Pluton', true, '', 'russie.jpg'),
    new Question("Nyctalope est une race naine d'antilope", false, 'C’est une aptitude à voir dans le noir', 'nyctalope.jpg'),
    new Question("Le Commodore 64 est l’ordinateur de bureau le plus vendu", true, '', 'commodore.jpg'),
    new Question('Le nom du drapeau des pirates est appelé "black skull"', false, 'Il est appelé Jolly Roger', 'pirate.png'),
    new Question('Haddock est le nom du chien de Tintin', false, "Mais non. C'est Milou", 'tintin.jpg'),
    new Question('La barbe des pharaons était fausse', true, "Ils utilisaient déjà des postiches à l'époque.", 'pharaon.jpg'),
    new Question("Au Québec tire toi une bûche veut dire \"viens t'asseoir\"", true, 'La bûche, fameuse chaise de bucheron', 'buche.jpg'),
    new Question('Le module lunaire Eagle de possédait de 4Ko de Ram', true, 'Dire que je me plains avec mes 8GO de ram sur mon mac', 'eagle.jpg'),
  ];

  int index = 0;
  int score = 0;
  int total = 0;

  @override
  void initState() {
    super.initState();
    actualQuestion = listQuestion[index];
    total = listQuestion.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText('Le Quizz'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomText('Question numéro ${index + 1}'),
            CustomText(
              'Score: $score / $total'
            ),
            Card(
              elevation: 10.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.height * 0.4,
                child: Image.asset(
                  'ImageAssets/${listQuestion[index].imageName}',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: CustomText(
                listQuestion[index].question,
                textAlign: TextAlign.justify
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: ElevatedButton(
                      onPressed: () {
                        answerQuestion(true);
                      },
                      child: CustomText(
                        'Vrai',
                        factor: 1.4
                      ),
                    )
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: ElevatedButton(
                      onPressed: () {
                        answerQuestion(false);
                      },
                      child: CustomText(
                        'Faux',
                        factor: 1.4
                      ),
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void answerQuestion(bool answer) {
    if(listQuestion[index].answer == answer) {
      score++;
      answerMessage(true);
    } else {
      answerMessage(false);
    }
  }

  Future<Null> answerMessage(bool correctAnswer) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Center(
                child: CustomText(
                  correctAnswer ? "C'est gagné !!" : "Oups !! Perdu...",
                  color: correctAnswer ? Colors.green : Colors.red,
                  size: 30.0
                )
            ),
            titlePadding: EdgeInsets.all(20.0),
            contentPadding: EdgeInsets.all(20.0),
            children: [
              Card(
                elevation: 10.0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Image.asset(
                    'ImageAssets/' + (correctAnswer ? 'vrai.jpg' : 'faux.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Center(
                  child: CustomText(
                    correctAnswer ? '' : listQuestion[index].comm,
                    size: 15.0,
                    style : FontStyle.italic
                  )
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      navToNextQuestion();
                    },
                    child: CustomText(
                      index < listQuestion.length - 1 ? 'Question suivante' : 'Score Final',
                      factor: 1.3
                    )
                ),
              )
            ],
          );
        }
    );
  }

  void navToNextQuestion() {
    if (index < listQuestion.length - 1) {
      index++;
      setState(() {
        actualQuestion = listQuestion[index];
      });
    }
    else {
      print('arrived to last question');
      finalScore();
    }
  }

  Future<Null> finalScore() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: CustomText(
                'Score Final',
                size: 40.0
              ),
            ),
            content: CustomText(
                'Votre score : $score / $total',
                color: Colors.indigo
              ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  child: CustomText(
                    'Ok',
                    size: 30.0,
                    style: FontStyle.italic
                  )
              )
            ],
          );
        }
    );
  }
}
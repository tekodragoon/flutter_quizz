import 'package:flutter/material.dart';
import 'package:flutter_quizz/models/Palette.dart';
import 'package:flutter_quizz/models/material_color_generator.dart';
import 'package:flutter_quizz/widgets/Home.dart';

class QuizzApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialColor primarySwatch = generateMaterialColor(Palette.primary);
    return MaterialApp(
      title: 'Flutter Quizz',
      theme: ThemeData(
          primarySwatch: primarySwatch,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: primarySwatch,
                  onPrimary: Colors.white,
                  onSurface: Colors.red
              )
          )
      ),
      debugShowCheckedModeBanner: false,
      home: Home(title: 'Quizzz'),
    );
  }
}
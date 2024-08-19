import 'package:flutter/material.dart';
import 'package:roll_the_dice/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
            Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 255, 187, 0)),
      ),
    ),
  );
}

import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller>
    with SingleTickerProviderStateMixin {
  var currentDiceRoll = 2;
  var isRolling = false;
  late Timer _timer;

  void rollDice() {
    if (isRolling) return;

    setState(() {
      isRolling = true;
    });

    // Show SnackBar with "The dice is rolling..."
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'The dice is rolling...',
          style: TextStyle(fontSize: 18),
        ),
        duration: const Duration(seconds: 3), // Lasts for the rolling duration
      ),
    );

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        currentDiceRoll = randomizer.nextInt(6) + 1;
        if (kDebugMode) {
          print(currentDiceRoll);
        }
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      _timer.cancel();
      setState(() {
        isRolling = false;
        currentDiceRoll = randomizer.nextInt(6) + 1;
      });

      // Show SnackBar with the final result
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Final Result: $currentDiceRoll',
            style: TextStyle(fontSize: 20),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: isRolling ? null : rollDice, // Disable tap while rolling
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: Image.asset(
              'assets/images/dice-$currentDiceRoll.png',
              key: ValueKey<int>(currentDiceRoll),
              width: 200,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed:
              isRolling ? null : rollDice, // Disable button while rolling
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(28),
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 28,
              )),
          child: const Text('Roll The Dice'),
        )
      ],
    );
  }
}

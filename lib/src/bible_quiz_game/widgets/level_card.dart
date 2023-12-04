import 'package:flutter/material.dart';

import '../constants.dart';

class LevelsCard extends StatelessWidget {
  const LevelsCard({
    super.key,
    required this.difficulty,
  });

  final String difficulty;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          elevation: 15,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              gradient: levelcardgradient,
              borderRadius: BorderRadius.circular(20),
            ),
            width: 100,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                difficulty,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

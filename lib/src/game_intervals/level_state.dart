import 'package:flutter/material.dart';

class LevelState extends ChangeNotifier {
  LevelState({required this.onWin, this.goal = 100});

  final VoidCallback onWin;
  final int goal;

  int _progress = 0;
  int get progress => _progress;
  void setProgress(int value) {
    _progress = value;
    notifyListeners();
  }

  void evaluate() {
    if (_progress >= goal) {
      onWin();
    }
  }
}

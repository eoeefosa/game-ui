import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplegame/src/bible_quiz_game/data/question_data.dart';

import '../model/question_model.dart';

enum AnswerCardStatus {
  normal,
  disabled,
  error,
  right,
}

final ChangeNotifierProvider<Questions> questionsProvider =
    ChangeNotifierProvider<Questions>(create: (context) => Questions());

class Questions extends ChangeNotifier {
  Questions();
  // TODO GameUser
  int? currentLevel;
  int currentQuestionIndex = 0;
  int? currentQuestionAnswerIndex;
  int rightAnswers = 0;
  bool isFinish = false;
  int? currentScore;

  Timer? timer;
  int seconds = 60;
  Question get currentQuestion =>
      questions[currentLevel! * 4 + currentQuestionIndex];
  List<int> ratings = List.generate(11, (index) => 0);

  Timer? questionTimer;

  List<Question> questions =
      questionsData.map((e) => Question.fromMap(e)).toList();
  bool get isChoseOption => answersStatus.contains(AnswerCardStatus.right);
  List<AnswerCardStatus> get answersStatus {
    // if no option is selected set AnswerCard to normal
    if (currentQuestionAnswerIndex == null) {
      return List.generate(
          currentQuestion.options.length, (index) => AnswerCardStatus.normal);
    } // if right option is selected set right option to right and other options to disabled
    else if (currentQuestion.options[currentQuestionAnswerIndex!] ==
        currentQuestion.answer) {
      return List.generate(currentQuestion.options.length, (index) {
        if (index == currentQuestionAnswerIndex) {
          return AnswerCardStatus.right;
        }
        return AnswerCardStatus.disabled;
      });
    } // if wrong answer is chosen set selected option to error and right answer to right
    else {
      return List.generate(currentQuestion.options.length, (index) {
        if (index == currentQuestionAnswerIndex) {
          return AnswerCardStatus.error;
        }
        if (currentQuestion.options[index] == currentQuestion.answer) {
          return AnswerCardStatus.right;
        }
        return AnswerCardStatus.disabled;
      });
    }
  }

  void changeRating(int rating, int level) {
    ratings[level] = rating;
    notifyListeners();
  }

  void chooseLevel(int level) {
    currentLevel = level;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        timer.cancel();
      } else {
        seconds--;
      }
      notifyListeners();
    });
  }

  void updateCurrentLevelRating() {
    // 2/4 scored
    if (rightAnswers <= 2) {
      ratings[currentLevel!] = 1;
    } //3/4 scored
    else if (rightAnswers <= 3) {
      ratings[currentLevel!] = 2;
    } else if (rightAnswers == 4) {
      ratings[currentLevel!] = 3;
    }
  }

  void reset() {
    currentScore = null;
    seconds = 60;
    timer = null;
    currentLevel = null;
    currentQuestionAnswerIndex = 0;
    rightAnswers = 0;
    isFinish = false;
    currentQuestionAnswerIndex = null;
    notifyListeners();
  }

  void chooseAnswer(int index) {
    currentQuestionAnswerIndex = index;
    notifyListeners();
    if (currentQuestion.answer == currentQuestion.options[index]) {
      rightAnswers++;
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex == 3) {
      currentScore = rightAnswers * (60 - seconds);
      seconds = 60;
      timer!.cancel();
      timer = null;
      updateCurrentLevelRating();
      isFinish = true;
    } else {
      currentQuestionIndex++;
      currentQuestionAnswerIndex = null;
    }
    notifyListeners();
  }
}

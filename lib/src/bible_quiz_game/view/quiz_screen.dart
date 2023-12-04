import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:simplegame/src/bible_quiz_game/provider/questions.dart';
import 'package:simplegame/src/bible_quiz_game/widgets/option_card.dart';
import 'package:simplegame/src/bible_quiz_game/widgets/quiz_title_bar.dart';

import '../widgets/customButton.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Questions>(
            create: (context) => Questions()..chooseLevel(1)),
      ],
      child: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1F1147), Color(0xff362679)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Consumer<Questions>(builder: (context, question, child) {
          // if (question.isFinish || question.seconds == 0) {
          //   GoRouter.of(context).go(WinGameScreen.route,
          //       extra: {'score': question.currentScore});
          // }
          return Column(
            children: [
              const SizedBox(height: 8),
              Titlebar(
                leveldifficulty: 'Level ${question.currentLevel}',
                maxStar: question.ratings[question.currentLevel!],
                score: question.rightAnswers,
                life: question.rightAnswers,
                totalseconds: 60,
                currentseconds: question.seconds,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                child: Text(
                  'Question ${question.currentQuestionIndex + 1}/4',
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
              Container(
                decoration: const BoxDecoration(),
                child: Center(
                  child: Text(
                    question.currentQuestion.question,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ...List.generate(
                  question.currentQuestion.options.length,
                  (index) => OptionCard(
                        option: question.currentQuestion.options[index],
                        answerCardStatus: question.answersStatus[index],
                        onTap: () {
                          question.chooseAnswer(index);
                        },
                      )),
              if (question.isChoseOption) ...[
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  padding: 0,
                  onPressed: question.isFinish
                      ? () {
                          GoRouter.of(context).go('/play/won_quiz',
                              extra: {'score': question.currentScore});
                        }
                      : question.nextQuestion,
                  text: question.isFinish ? 'See my Score' : 'Next Question',
                ),
              ]
            ],
          );
        }),
      )),
    );
  }
}

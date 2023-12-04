// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:simplegame/src/bible_quiz_game/provider/questions.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    Key? key,
    required this.option,
    required this.answerCardStatus,
    this.onTap,
  }) : super(key: key);

  final String option;
  final AnswerCardStatus answerCardStatus;
  final VoidCallback? onTap;

//   @override
//   State<OptionCard> createState() => OptionCardState();
// }

// class OptionCardState extends State<OptionCard> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
            color: bgColor(answerCardStatus),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor(answerCardStatus), width: 3)),
        child: Row(
          children: [
            Expanded(
                child: Text(
              option,
              style: TextStyle(
                color: textColor(answerCardStatus),
              ),
            )),
            Icon(
              adaptiveIcon(answerCardStatus),
              color: textColor(answerCardStatus),
            )
          ],
        ),
      ),
    );
  }
}

Color textColor(AnswerCardStatus answerCardStatus) {
  switch (answerCardStatus) {
    case AnswerCardStatus.error:
      return Colors.redAccent;
    case AnswerCardStatus.right:
      return Colors.green;
    case AnswerCardStatus.disabled:
      return Colors.black26;
    default:
      return Colors.black54;
  }
}

Color borderColor(AnswerCardStatus answerCardStatus) {
  switch (answerCardStatus) {
    case AnswerCardStatus.error:
      return Colors.redAccent;
    case AnswerCardStatus.right:
      return Colors.green;
    case AnswerCardStatus.disabled:
      return Colors.grey.shade100;
    default:
      return Colors.grey.shade300;
  }
}

Color bgColor(AnswerCardStatus answerCardStatus) {
  switch (answerCardStatus) {
    case AnswerCardStatus.error:
      return const Color.fromARGB(71, 255, 79, 62);
    case AnswerCardStatus.right:
      return const Color.fromARGB(55, 69, 255, 76);

    default:
      return Colors.white;
  }
}

IconData adaptiveIcon(AnswerCardStatus answerCardStatus) {
  switch (answerCardStatus) {
    case AnswerCardStatus.error:
      return Icons.error;
    case AnswerCardStatus.right:
      return Icons.check_circle;

    default:
      return Icons.circle_outlined;
  }
}

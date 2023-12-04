import 'package:flutter/material.dart';
import 'package:simplegame/src/bible_quiz_game/constants.dart';
import 'package:simplegame/src/bible_quiz_game/widgets/level_card.dart';

class Titlebar extends StatefulWidget {
  const Titlebar({
    super.key,
    required this.leveldifficulty,
    required this.maxStar,
    required this.score,
    required this.life,
    required this.totalseconds,
    required this.currentseconds,
  });
  // TODO: FIX THE ISSUE
  final String leveldifficulty;
  final int maxStar;
  final int score;
  final int life;
  final int totalseconds;
  final int currentseconds;

  @override
  State<Titlebar> createState() => _TitlebarState();
}

class _TitlebarState extends State<Titlebar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 16,
        ),
        InkWell(
          onTap: () {
            // Navigator.of(context).push(createRoute(const LevelScreen()));
          },
          child: LevelsCard(
            difficulty: widget.leveldifficulty,
          ),
        ),
        const Spacer(),
        CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: (widget.currentseconds) < widget.totalseconds / 6
              ? Colors.green[800]
              : (widget.currentseconds) < widget.totalseconds / 3
                  ? Colors.yellow[800]
                  : Colors.red[800],
          strokeWidth: 6.0,
          value: widget.currentseconds / widget.totalseconds,
          strokeCap: StrokeCap.round,
        ),
        const Spacer(),
        Row(
          children: List.generate(
            3,
            (index) => Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return stargradient.createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: const Icon(
                    Icons.star_rate_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                )),
          ),
        )
      ],
    );
  }
}

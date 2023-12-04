import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:simplegame/src/games_services/score.dart';
import 'package:simplegame/src/style/constants.dart';
import 'package:simplegame/src/style/palette.dart';
import 'package:simplegame/src/style/responsive_screen.dart';

class WinGameScreen extends StatelessWidget {
  const WinGameScreen({
    super.key,
    // required this.score,
    this.score,
    this.scorenumber,
  });
  // final Score score;
  final Score? score;
  final int? scorenumber;
  static const route = '/play/won';
  static const routename = 'won';

  @override
  Widget build(BuildContext context) {
    // TODO: INITIAL adscontrollerAvaliable and adsRemoved
    // final adsControllerAvaliable = context.watch<AdsController?>() != null;
    // final adsRemoved =context.watch<>()?.
    final palette = context.watch<Palette>();
    const gap = SizedBox(height: 10);
    return Scaffold(
      backgroundColor: palette.backgroundPlaySession,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            // TODO: BANNERADWIGET BASED ON addcontroller
            // gap,
            const Center(
              child: Text(
                'You won!',
                style: TextStyle(
                  fontFamily: AppConstants.fontfamilypermenent,
                  fontSize: 50,
                ),
              ),
            ),
            gap,
            Center(
              child: Text(
                'Score: ${score == null ? scorenumber : score!.score}\n'
                'Time: ${score == null ? scorenumber : score!.formattedTime}',
                style: const TextStyle(
                    fontFamily: AppConstants.fontfamilypermenent, fontSize: 20),
              ),
            ),
          ],
        ),
        rectangularMenuArea: ElevatedButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: const Text('Continue'),
        ),
      ),
    );
  }
}
